//
//  WeView2StackLayout.m
//  Unknown Project
//
//  Copyright (c) 2013 Charles Matthew Chen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "WeView2StackLayout.h"
#import "UIView+WeView2.h"
#import "WeView2Macros.h"

@implementation WeView2StackLayout

+ (WeView2StackLayout *)stackLayout
{
    WeView2StackLayout *layout = [[WeView2StackLayout alloc] init];
    return layout;
}

// TODO: Honor max/min widths in the earlier phases, of "min size" and "layout" functions.
// TODO: Do we need to honor other params as well?
- (CGSize)minSizeOfContentsView:(UIView *)view
                       subviews:(NSArray *)subviews
                   thatFitsSize:(CGSize)guideSize
{
    if ([subviews count] < 1)
    {
        return [self insetSizeOfView:view];
    }

    BOOL debugMinSize = [self debugMinSize:view];
    int indent = 0;
    if (debugMinSize)
    {
        indent = [self viewHierarchyDistanceToWindow:view];
        NSLog(@"%@+ [%@ (%@) minSizeOfContentsView: %@] thatFitsSize: %@",
              [self indentPrefix:indent],
              [self class],
              view.debugName,
              [view class],
              NSStringFromCGSize(guideSize));
    }

    CGRect contentBounds = [self contentBoundsOfView:view
                                             forSize:guideSize];

    if (debugMinSize)
    {
        NSLog(@"%@ contentBounds: %@, guideSize: %@, insetSizeOfView: %@",
              [self indentPrefix:indent + 1],
              FormatRect(contentBounds),
              FormatSize(guideSize),
              FormatSize([self insetSizeOfView:view]));
    }

    CGSize maxSubviewSize = CGSizeZero;
    for (int i=0; i < [subviews count]; i++)
    {
        UIView* subview = subviews[i];

        // TODO: In our initial pass, should we be using a guide size of
        // CGFLOAT_MAX, CGFLOAT_MAX?
        CGSize subviewSize = [self desiredItemSize:subview
                                           maxSize:contentBounds.size];
        maxSubviewSize = CGSizeMax(maxSubviewSize, subviewSize);
    }

    CGSize result = CGSizeAdd(maxSubviewSize,
                              [self insetSizeOfView:view]);
    if (debugMinSize)
    {
        NSLog(@"%@ thatFitsSize: = %@",
              [self indentPrefix:indent + 1],
              NSStringFromCGSize(result));
    }
    return result;
}

- (void)layoutContentsOfView:(UIView *)view
                    subviews:(NSArray *)subviews
{
    if ([subviews count] < 1)
    {
        return;
    }

    BOOL debugLayout = [self debugLayout:view];
    int indent = 0;
    CGSize guideSize = view.size;
    if (debugLayout)
    {
        indent = [self viewHierarchyDistanceToWindow:view];
        NSLog(@"%@+ [%@ (%@) layoutContentsOfView: %@] : %@",
              [self indentPrefix:indent],
              [self class],
              view.debugName,
              [view class],
              NSStringFromCGSize(guideSize));
    }

    CGRect contentBounds = [self contentBoundsOfView:view
                                             forSize:view.size];

    if (debugLayout)
    {
        NSLog(@"%@ contentBounds: %@, guideSize: %@, insetSizeOfView: %@",
              [self indentPrefix:indent + 1],
              FormatRect(contentBounds),
              FormatSize(guideSize),
              FormatSize([self insetSizeOfView:view]));
    }

    BOOL cropSubviewOverflow = [self cropSubviewOverflow:view];
    CellPositioningMode cellPositioning = [self cellPositioning:view];
    for (int i=0; i < [subviews count]; i++)
    {
        UIView* subview = subviews[i];

        CGSize subviewSize = [self desiredItemSize:subview
                                           maxSize:contentBounds.size];

        if (cropSubviewOverflow)
        {
            subviewSize = CGSizeMin(subviewSize, contentBounds.size);
        }

        CGRect cellBounds = contentBounds;
        [self positionSubview:subview
                  inSuperview:view
                     withSize:subviewSize
                 inCellBounds:cellBounds
              cellPositioning:cellPositioning];

        if (debugLayout)
        {
            NSLog(@"%@ - final layout[%d] %@: %@, cellBounds: %@, subviewSize: %@",
                  [self indentPrefix:indent + 2],
                  i,
                  [subview class],
                  FormatRect(subview.frame),
                  FormatRect(cellBounds),
                  FormatCGSize(subviewSize));
        }
    }
}

@end
