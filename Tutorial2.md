---
permalink: Tutorial2.html
layout: default
---

Next\: [Tutorial 3: Test](Tutorial3.html)

Tutorial 2: iPhone Demo
==

<!-- TEMPLATE START -->

<video WIDTH="720" HEIGHT="720" AUTOPLAY="true" controls="true" LOOP="true" class="embedded_video" >
    <source src="videos/video-E268F6BC-4360-47CE-8EC4-36D19B2D15EF-76443-0005E485C8E73782.mp4" type="video/mp4" />
    <source src="videos/video-E268F6BC-4360-47CE-8EC4-36D19B2D15EF-76443-0005E485C8E73782.webm" type="video/webm" />
</video>


* There are two WeViews in this layout: the outer _rootView_ and the inner _bodyView_.  
* The _rootView_ contains the toolbar and _bodyView_ in a __vertical layout__.
* The _bodyView_ is configured with __\[UIView setStretches\]__ which indicates to the layout that it 
should be stretched to receive any extra space in the layout.
* The _bodyView_ is also configured with __\[UIView setIgnoreDesiredSize\]__ which indicates to the layout that the __desired size__ of this view should be ignored.
* A background image is added to the _bodyView_ with a custom layout that exactly fills the _bodyView_'s bounds while retaining its aspect ratio.
* A group of three buttons is added to the _bodyView_ using a horizontal layout.  This layout has __bottom alignment__ and a 20pt __bottom margin__.
* An activity indicator is added to the _bodyView_ with its own layout.  That layout doesn't need to be configured, since the default behavior is to center subviews within their superview.
* The _bodyView_ contains three separate groups of subviews: the background, the buttons and the activity indicator.  __Each group of subviews has its own layout__.  The layouts work independently and only affect their subviews.  
* __Each layout can be configured separately__.  For example, the buttons' layout has bottom alignment, but that doesn't effect the activity indicator because it has a separate layout.
 

Here's the code:

{% gist 6489214 %}



The _bodyView_ is also configured with _\[UIView setIgnoreDesiredSize\]_ which indicates to the layout that the __desired size__ of this view should be ignored.


![Layout Snapshot](images/snapshot-397477B6-5DFF-4EFE-981D-9F1A287DA87F-81210-0003C33F3794A10F-1.png)
![Layout Snapshot](images/snapshot-397477B6-5DFF-4EFE-981D-9F1A287DA87F-81210-0003C33F3794A10F-0.png)

A WeView layou

![Layout Snapshot](images/snapshot-397477B6-5DFF-4EFE-981D-9F1A287DA87F-81210-0003C33F3794A10F-2.png)
![Layout Snapshot](images/snapshot-397477B6-5DFF-4EFE-981D-9F1A287DA87F-81210-0003C33F3794A10F-1.png)
![Layout Snapshot](images/snapshot-397477B6-5DFF-4EFE-981D-9F1A287DA87F-81210-0003C33F3794A10F-0.png)



![Layout Snapshot](images/snapshot-0-0.png)
![Layout Snapshot](images/snapshot-0-1.png)
![Layout Snapshot](images/snapshot-0-2.png)


![Layout Snapshot](images/snapshot-0-0.png)
![Layout Snapshot](images/snapshot-0-1.png)
![Layout Snapshot](images/snapshot-0-2.png)

<!-- TEMPLATE END -->

Next\: [Tutorial 3: Test](Tutorial3.html)