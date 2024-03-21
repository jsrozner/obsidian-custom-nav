# Background
Obsidian does not enable navigation in numerous menus, e.g., 
- version sync view
- settings page

Ideally we would have
- keyboard navigation
- filtering capability

This extension is built by going into the DOM and manually manipulating nodes
using, e.g. click(). It is inherently fragile.

## Installation
This extension is firmly in beta. Use the [BRAT plugin](https://github.com/TfTHacker/obsidian42-brat) to
install. 

## Contributions 
- Contributions are welcome! But the first step should be cleaning up the framework
approach.

## Currently implemented
### Sync page
- use up/down/left/right to navigate the sync pane
- Not implemented
  - can't expand load more

### Not implemented
- Any sort of filtering
- Other menus

# Framework
Ideally others could use the same framework to enable navigation on more pages 
and to fix this extension if anything changes.

## Basic functionality
- Watches for page mutations
- Walks down the node change for the mutation to see if the menu page we are
looking for is open
- If yes, parses the elements into classes that can be more safely manipulated
- There is some safety built in

## Todos
### Framework
I'd like this to be more of an automatic framework using proxies:
- Classes should be autobuilt from a reflection from classname -> class
- When accessing node children, siblings, etc, we should autoconstruct with appropriate class
- Should be clearer how to contribute

