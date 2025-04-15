/* 
To ensure that section bibliography are rendered correctly in PDF for the Introduction 
I moved the Introduction chapter inside a book part (tmp workaround)

Now I have to fix the HTML sidebar so that the chapter does no look nested.
I target the .sidebar-item-container whose menu-text is empty, moving its 
.sidebar-item child up one level, and then removing the empty container. 
*/

document.addEventListener("DOMContentLoaded", function() {
    
    console.log("sidebar-tweak.js running");

    function moveAndStyleSidebarItem() {
        var sectionUl = document.querySelector('ul#quarto-sidebar-section-1');
        if (sectionUl) {
          var li = sectionUl.parentElement;
          if (li && li.classList.contains('sidebar-item-section')) {
            // Move the <ul> to be a sibling after its parent <li>
            li.parentNode.insertBefore(sectionUl, li.nextSibling);
            // Remove the now-empty <li>
            li.remove();
          }
    
          // Style the moved link to mimic the original sidebar item
          var movedLinks = sectionUl.querySelectorAll('.sidebar-item-text.sidebar-link');
          movedLinks.forEach(function (link) {
            link.style.fontSize = "1.06em"; // Increase font size
            var sidebarItem = link.closest('.sidebar-item');
            if (sidebarItem) {
              sidebarItem.style.marginLeft = "-0.6em"; // Adjust margin to align with the rest
            }
          });
        }
      }

    // Initial application of the script
    moveAndStyleSidebarItem();
  
    // Set up a MutationObserver to watch for changes in the sidebar
    var observer = new MutationObserver(function (mutationsList) {
      for (var mutation of mutationsList) {
        if (mutation.type === 'childList') {
          moveAndStyleSidebarItem();
        }
      }
    });
  
    // Observe changes in the body (or a more specific container like #quarto-sidebar)
    observer.observe(document.body, { childList: true, subtree: true });
    
});
