#custom vscode commands go here
app.name: Code
app.name: Cursor
app.name: Windsurf
-
tag(): user.find_and_replace
tag(): user.line_commands
tag(): user.multiple_cursors
# tag(): user.splits
tag(): user.tabs
tag(): user.command_search

window reload: 
    user.run_rpc_command("workbench.action.reloadWindow")
window close: 
    user.run_rpc_command("workbench.action.closeWindow")
#multiple_cursor.py support end

go view [<user.text>]:
    user.run_rpc_command("workbench.action.openView")
    insert(user.text or "")

 ## +++++++++++++++++++++++++++ Sidebar .

bar explore | [bar] explorer: 
    user.run_rpc_command("workbench.view.explorer")

bar extensions: 
    user.run_rpc_command("workbench.view.extensions")

bar outline: 
    user.run_rpc_command("outline.focus")

bar run: 
    user.run_rpc_command("workbench.view.debug")

bar search: 
    user.run_rpc_command("workbench.view.search")

bar source: 
    user.run_rpc_command("workbench.view.scm")

bar test: 
    user.run_rpc_command("workbench.view.testing.focus")

bar switch: 
    user.run_rpc_command("workbench.action.toggleSidebarVisibility")

 ## +++++++++++++++++++++ Symbol search .

symbol hunt [<user.text>]:
    user.run_rpc_command("workbench.action.gotoSymbol")
    sleep(50ms)
    insert(text or "")

symbol hunt all [<user.text>]:
    user.run_rpc_command("workbench.action.showAllSymbols")
    sleep(50ms)
    insert(text or "")

 ## ++++++++++++++++++++++++++++ Panels .

panel control: 
    user.run_rpc_command("workbench.panel.repl.view.focus")

panel output: 
    user.run_rpc_command("workbench.panel.output.focus")

panel problems: 
    user.run_rpc_command("workbench.panel.markers.view.focus")

panel switch: 
    user.run_rpc_command("workbench.action.togglePanel")

(panel | go | open | show) (terminal | term): 
    user.run_rpc_command("workbench.action.terminal.focus")

focus editor: 
    user.run_rpc_command("workbench.action.focusActiveEditorGroup")

 ## ++++++++++++++++++++++++++ Settings .

show settings: 
    user.run_rpc_command("workbench.action.openGlobalSettings")

show settings json: 
    user.run_rpc_command("workbench.action.openSettingsJson")

show settings folder: 
    user.run_rpc_command("workbench.action.openFolderSettings")

show settings folder json: 
    user.run_rpc_command("workbench.action.openFolderSettingsFile")

show settings workspace: 
    user.run_rpc_command("workbench.action.openWorkspaceSettings")

show settings workspace json: 
    user.run_rpc_command("workbench.action.openWorkspaceSettingsFile")

(show | go) shortcuts: 
    user.run_rpc_command("workbench.action.openGlobalKeybindings")

show shortcuts json: 
    user.run_rpc_command("workbench.action.openGlobalKeybindingsFile")

show snippets: 
    user.run_rpc_command("workbench.action.openSnippets")

 ## +++++++++++++++++++ VSCode Snippets .

snip (last | previous): 
    user.run_rpc_command("jumpToPrevSnippetPlaceholder")

snip next: 
    user.run_rpc_command("jumpToNextSnippetPlaceholder")

 ## +++++++++++++++++++++++++++ Display .

centered switch: 
    user.run_rpc_command("workbench.action.toggleCenteredLayout")

fullscreen switch: 
    user.run_rpc_command("workbench.action.toggleFullScreen")

theme switch | color theme: 
    user.run_rpc_command("workbench.action.selectTheme")

wrap switch: 
    user.run_rpc_command("editor.action.toggleWordWrap")

zen switch: 
    user.run_rpc_command("workbench.action.toggleZenMode")

 ## +++++++++++++++++++++ File Commands .

file hunt [<user.text>]:
    user.run_rpc_command("workbench.action.quickOpen")
    sleep(50ms)
    insert(text or "")

file hunt (pace | paste):
    user.run_rpc_command("workbench.action.quickOpen")
    sleep(50ms)
    edit.paste()

file copy name: 
    user.run_rpc_command("fileutils.copyFileName")

file copy path: 
    user.run_rpc_command("copyFilePath")

file copy local [path]: 
    user.run_rpc_command("copyRelativeFilePath")

file create sibling: 
    user.vscode_and_wait("explorer.newFile")

file create: 
    user.run_rpc_command("workbench.action.files.newUntitledFile")

file create relative: 
    user.run_rpc_command("fileutils.newFile")

file create root: 
    user.run_rpc_command("fileutils.newFileAtRoot")

file rename:
    user.run_rpc_command("fileutils.renameFile")
    sleep(150ms)

file move:
    user.run_rpc_command("fileutils.moveFile")
    sleep(150ms)

file clone:
    user.run_rpc_command("fileutils.duplicateFile")
    sleep(150ms)

file delete:
    user.run_rpc_command("fileutils.removeFile")
    sleep(150ms)

file open folder: user.run_rpc_command("revealFileInOS")

file reveal: 
    user.run_rpc_command("workbench.files.action.showActiveFileInExplorer")

save ugly: 
    user.run_rpc_command("workbench.action.files.saveWithoutFormatting")

 ## +++++++++++++++++ Language Features .

suggest show:
	 user.run_rpc_command("editor.action.triggerSuggest")

hint show:
	 user.run_rpc_command("editor.action.triggerParameterHints")

definition show:
	 user.run_rpc_command("editor.action.revealDefinition")

(def | deaf | definition) peek:
	 user.run_rpc_command("editor.action.peekDefinition")

(def | deaf | definition) side:
	 user.run_rpc_command("editor.action.revealDefinitionAside")

references show:
	 user.run_rpc_command("editor.action.goToReferences")

hierarchy peek:
	 user.run_rpc_command("editor.showCallHierarchy")

references find:
	 user.run_rpc_command("references-view.find")

format that:
	 user.run_rpc_command("editor.action.formatDocument")

format selection:
	 user.run_rpc_command("editor.action.formatSelection")

imports organize:
	 user.run_rpc_command("editor.action.organizeImports")

problem next:
	 user.run_rpc_command("editor.action.marker.nextInFiles")

problem last:
	 user.run_rpc_command("editor.action.marker.prevInFiles")

problem fix:
	 user.run_rpc_command("problems.action.showQuickFixes")

rename that:
	 user.run_rpc_command("editor.action.rename")

refactor (that | this):
	 user.run_rpc_command("editor.action.refactor")

whitespace trim:
	 user.run_rpc_command("editor.action.trimTrailingWhitespace")

language switch:
	 user.run_rpc_command("workbench.action.editor.changeLanguageMode")


## +++++++++++++++++++ code navigation .

(go declaration | follow): 
    user.run_rpc_command("editor.action.revealDefinition")

go back: 
    user.run_rpc_command("workbench.action.navigateBack")

go forward: 
    user.run_rpc_command("workbench.action.navigateForward")

go implementation: 
    user.run_rpc_command("editor.action.goToImplementation")

go type: 
    user.run_rpc_command("editor.action.goToTypeDefinition")

go usage: 
    user.run_rpc_command("references-view.find")

pick recent project [folder] [<user.text>]:
    user.run_rpc_command("workbench.action.openRecent")
    sleep(50ms)
    insert(text or "")

go edit: user.run_rpc_command("workbench.action.navigateToLastEditLocation")

## +++++++++++++++++++++++++ bookmarks .

# Bookmarks. Requires Bookmarks plugin
# bar marks: user.run_rpc_command("workbench.view.extension.bookmarks")
# go marks:
#     user.deprecate_command("2023-06-06", "go marks", "bar marks")
#     user.run_rpc_command("workbench.view.extension.bookmarks")
# toggle mark: user.run_rpc_command("bookmarks.toggle")
# go next mark: user.run_rpc_command("bookmarks.jumpToNext")
# go last mark: user.run_rpc_command("bookmarks.jumpToPrevious")

## ++++++++++++++++++++++++ close tabs .

close other tabs: 
    user.run_rpc_command("workbench.action.closeOtherEditors")

close all tabs: 
    user.run_rpc_command("workbench.action.closeAllEditors")

close tabs way right: 
    user.run_rpc_command("workbench.action.closeEditorsToTheRight")

close tabs way left: 
    user.run_rpc_command("workbench.action.closeEditorsToTheLeft")

## +++++++++++++++++++++++++++ Folding .

fold (that | here): user.run_rpc_command("editor.fold")

unfold (that | here): user.run_rpc_command("editor.unfold")

fold point: 
    mouse_click(0)
    user.run_rpc_command("editor.fold")

unfold point: 
    mouse_click(0)
    user.run_rpc_command("editor.unfold")

fold (those | form): 
    user.run_rpc_command("editor.foldAllMarkerRegions")

unfold (those | form | deep): 
    user.run_rpc_command("editor.unfoldRecursively")

fold all: 
    user.run_rpc_command("editor.foldAll")

unfold all: 
    user.run_rpc_command("editor.unfoldAll")

fold comments: user.run_rpc_command("editor.foldAllBlockComments")

fold one: user.run_rpc_command("editor.foldLevel1")
fold two: user.run_rpc_command("editor.foldLevel2")
fold three: user.run_rpc_command("editor.foldLevel3")
fold four: user.run_rpc_command("editor.foldLevel4")
fold five: user.run_rpc_command("editor.foldLevel5")
fold six: user.run_rpc_command("editor.foldLevel6")
fold seven: user.run_rpc_command("editor.foldLevel7")

## +++++++++++++++++++++++++ git stuff .

# Git / Github (not using verb-noun-adjective pattern, mirroring terminal commands.)
git branch: user.run_rpc_command("git.branchFrom")
git branch this: user.run_rpc_command("git.branch")

git checkout [<user.text>]:
    user.run_rpc_command("git.checkout")
    sleep(50ms)
    insert(text or "")

git commit [<user.text>]:
    user.run_rpc_command("git.commitStaged")
    sleep(100ms)
    user.insert_formatted(text or "", "CAPITALIZE_FIRST_WORD")

git commit undo: user.run_rpc_command("git.undoCommit")
git commit amend: user.run_rpc_command("git.commitStagedAmend")
git diff: user.run_rpc_command("git.openChange")
git fetch: user.run_rpc_command("git.fetch")
git fetch all: user.run_rpc_command("git.fetchAll")
git ignore: user.run_rpc_command("git.ignore")
git merge: user.run_rpc_command("git.merge")
git output: user.run_rpc_command("git.showOutput")
git pull: user.run_rpc_command("git.pullRebase")
git push: user.run_rpc_command("git.push")
git push force: user.run_rpc_command("git.pushForce")
git rebase abort: user.run_rpc_command("git.rebaseAbort")
git reveal: user.run_rpc_command("git.revealInExplorer")
git revert: user.run_rpc_command("git.revertChange")
git stash: user.run_rpc_command("git.stash")
git stash pop: user.run_rpc_command("git.stashPop")
git status: user.run_rpc_command("workbench.scm.focus")
git stage: user.run_rpc_command("git.stage")
git stage all: user.run_rpc_command("git.stageAll")
git sync: user.run_rpc_command("git.sync")
git unstage: user.run_rpc_command("git.unstage")
git unstage all: user.run_rpc_command("git.unstageAll")
pull request: user.run_rpc_command("pr.create")

# Use keyboard shortcuts because VSCode relies on when clause contexts to choose the appropriate
# action: https://code.visualstudio.com/api/references/when-clause-contexts
change next: key(alt-f5)
change last: key(shift-alt-f5)

 ## +++++++++++++++++++++++++++ Testing .

test run: user.run_rpc_command("testing.runAtCursor")
test run file: user.run_rpc_command("testing.runCurrentFile")
test run all: user.run_rpc_command("testing.runAll")
test run failed: user.run_rpc_command("testing.reRunFailTests")
test run last: user.run_rpc_command("testing.reRunLastRun")

test debug: user.run_rpc_command("testing.debugAtCursor")
test debug file: user.run_rpc_command("testing.debugCurrentFile")
test debug all: user.run_rpc_command("testing.debugAll")
test debug failed: user.run_rpc_command("testing.debugFailTests")
test debug last: user.run_rpc_command("testing.debugLastRun")

test cancel: user.run_rpc_command("testing.cancelRun")

 ## +++++++++++++++++++++++++ Debugging .

break point: 
    user.run_rpc_command("editor.debug.action.toggleBreakpoint")
step over: 
    user.run_rpc_command("workbench.action.debug.stepOver")
debug step into: 
    user.run_rpc_command("workbench.action.debug.stepInto")
debug step out [of]: 
    user.run_rpc_command("workbench.action.debug.stepOut")
debug start: 
    user.run_rpc_command("workbench.action.debug.start")
debug pause: 
    user.run_rpc_command("workbench.action.debug.pause")
debug stopper: 
    user.run_rpc_command("workbench.action.debug.stop")
debug continue: 
    user.run_rpc_command("workbench.action.debug.continue")
debug restart: 
    user.run_rpc_command("workbench.action.debug.restart")
debug console: 
    user.run_rpc_command("workbench.debug.action.toggleRepl")
debug clean: 
    user.run_rpc_command("workbench.debug.panel.action.clearReplAction")

 ## ++++++++++++++++++++++++++ Terminal .

(terminal  |  term) external: 
    user.run_rpc_command("workbench.action.terminal.openNativeConsole")

(terminal  |  term) new: 
    user.run_rpc_command("workbench.action.terminal.new")

(terminal  |  term) next: 
    user.run_rpc_command("workbench.action.terminal.focusNext")

(terminal  |  term) last: 
    user.run_rpc_command("workbench.action.terminal.focusPrevious")

(terminal  |  term) split: 
    user.run_rpc_command("workbench.action.terminal.split")

(terminal  |  term) zoom: 
    user.run_rpc_command("workbench.action.toggleMaximizedPanel")

(terminal  |  term) trash | kill (terminal  |  term): 
    user.run_rpc_command("workbench.action.terminal.kill")

(terminal  |  term) [panel] (toggle | show) | (toggle | show | hide) (terminal | term) [panel] : 
    user.vscode_and_wait("workbench.action.terminal.toggleTerminal")

(terminal  |  term) scroll up: 
    user.run_rpc_command("workbench.action.terminal.scrollUp")

(terminal  |  term) scroll down: 
    user.run_rpc_command("workbench.action.terminal.scrollDown")

(terminal  |  term) <number_small>: 
    user.vscode_terminal(number_small)

## +++++++++++++++++++++++++++++ tasks .

task run [<user.text>]:
    user.run_rpc_command("workbench.action.tasks.runTask")
    insert(user.text or "")

## +++++++++++++++++++++++++ copy line .

#TODO: should this be added to linecommands?
(clone | copy) (line | nine) [down]: 
    user.run_rpc_command("editor.action.copyLinesDownAction")

(clone | copy) (line | nine) up: 
    user.run_rpc_command("editor.action.copyLinesUpAction")

 ## +++++++ Expand/Shrink AST Selection .
select less: 
    user.run_rpc_command("editor.action.smartSelect.shrink")

select (more | this): 
    user.run_rpc_command("editor.action.smartSelect.expand")

## +++++++++++++++++++++++++++ minimap .

minimap: 
    user.run_rpc_command("editor.action.toggleMinimap")

## ++++++++++++++++++++ min/max editors .

maximize: 
    user.run_rpc_command("workbench.action.minimizeOtherEditors")

restore: 
    user.run_rpc_command("workbench.action.evenEditorWidths")

full screen: 
    user.run_rpc_command("workbench.action.toggleFullScreen")

## +++++++++++++++++++++++++++++ hover .

hover show | (show | pop) (hover | tool tip | tooltip) | (tool tip | tooltip): 
    user.run_rpc_command("editor.action.showHover")

## ++++++++++++++++++++++++ join lines .

join lines: 
    user.run_rpc_command("editor.action.joinLines")

curse undo: 
    user.run_rpc_command("cursorUndo")
curse redo: 
    user.run_rpc_command("cursorRedo")

select word: 
    user.run_rpc_command("editor.action.addSelectionToNextFindMatch")

skip word: 
    user.run_rpc_command("editor.action.moveSelectionToNextFindMatch")

# jupyter
# cell next: user.run_rpc_command("notebook.focusNextEditor")
# cell last: user.run_rpc_command("notebook.focusPreviousEditor")
# cell run above: user.run_rpc_command("notebook.cell.executeCellsAbove")
# cell run: user.run_rpc_command("notebook.cell.execute")

install local: 
    user.run_rpc_command("workbench.extensions.action.installVSIX")

preview markdown: 
    user.run_rpc_command("markdown.showPreview")

imports fix:
    user.vscode_add_missing_imports()
    sleep(100ms)
    user.run_rpc_command("editor.action.organizeImports")

replace here:
    user.replace("")
    key(cmd-alt-l)

# select breadcrumb: 
#     user.run_rpc_command("breadcrumbs.focusAndSelect")