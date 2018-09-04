// -*- mode: js;-*-

// General Actions

// define-key(content_buffer_normal_keymap, "y", "copy");

// add_hook("window_before_close_hook",
//          function () {
//              var w = get_recent_conkeror_window();
//              var result = (w == null) ||
//                  "y" == (yield w.minibuffer.read_single_character_option(
//                      $prompt = "Quit Conkeror? (y/n)",
//                      $options = ["y", "n"]));
//              yield co_return(result);
//          });


// homepage = "https://www.google.com";
// homepage = "http://lihebi.com";
homepage = "http://wiki.lihebi.com"
homepage = "http://google.com"
homepage = "file:////home/hebi/github/homepage-dist/index.html"

// sheet.appendRelativePath(".hebi/conkeror.css");
// register_user_stylesheet(make_uri(sheet));

// let (sheet = get_home_directory()) {
//     sheet.appendRelativePath(".conkerorrc/main.css");
//     register_user_stylesheet(make_uri(sheet));
// }
register_user_stylesheet("file:///home/hebi/.hebi/conkerorrc/main.css");

isearch_keep_selection = true;
isearch_scroll_center_vertically = true;

cwd = get_home_directory();
cwd = make_file("~/Downloads");

dowload_buffer_automatic_open_target = OPEN_NEW_BUFFER

editor_shell_command = "emacsclient"

// theme
// CAUTION: Require init the submodule in .hebi!

// theme_load_paths.unshift("~/.hebi/conkeror/themes/");
// theme_unload("default");
// theme_load("conkeror-theme-zenburn");

require("new-tabs.js");

// mode line

require("mode-line.js");
// remove_hook("mode_line_hook", mode_line_adder(clock_widget));
// add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
// add_hook("mode_line_hook", mode_line_adder(loading_count_widget), true);
// add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);
// add_hook("mode_line_hook", mode_line_adder(zoom_widget));
// add_hook("mode_line_hook", mode_line_adder(downloads_status_widget));

//////////////////////////////
// Trying to add hook to forbid website key binding hijack
// Failed
//////////////////////////////

// function hebiecho() {
//   // I.window.minibuffer.message("hebi");
// }

// function echo_message (window, message) {
//     window.minibuffer.message(message);
// }


// Weired!
// interactive("hebiecho",
//   "echo ..."
//   function (I) {
//       I.window.minibuffer.message("hebi");
//   });


// interactive("hebiecho",
//             "echo a user-supplied message in the minibuffer",
//             function (I) {
//                 echo_message(I.window, "hebi");
//             });

// interactive("echo-message",
//             "echo a user-supplied message in the minibuffer",
//             function (I) {
//                 echo_message(
//                     I.window,
//                     (yield I.minibuffer.read($prompt = "message: ")));
//             });

// define_key(content_buffer_normal_keymap, "C-o", "hebiecho",
//            $browser_object = browser_object_dom_node);

// add_hook("content_buffer_finished_loading_hook", "echo-message", false, false);


/*******************************
 * Web jumps
 *******************************/

define_webjump("ratpoisonwiki", "http://ratpoison.wxcvbn.org/cgi-bin/wiki.pl?search=%s");
define_webjump("github", "http://github.com/search?q=%s");
define_webjump("leetcode", "http://leetcode.com");
define_webjump("leetdiscuss", "https://discuss.leetcode.com/category/8/oj");
define_webjump("hackernews", "https://news.ycombinator.com/");

// ISU
define_webjump("cymail", "http://cymail.iastate.edu");
define_webjump("isulib", "http://www.lib.iastate.edu/");
define_webjump("isugit", "http://git.linux.iastate.edu");
define_webjump("isublackboard", "http://bb.its.iastate.edu");
define_webjump("isuaccessplus", "http://accessplus.iastate.edu");
define_webjump("isuvmaster", "http://vmaster.las.iastate.edu")

define_webjump("doccpp", "http://www.cplusplus.com/search.do?q=%s");
define_webjump("localwiki", "file:////home/hebi/github/wiki-dist/index.html");

// HEBI
define_webjump("hebiwiki", "http://wiki.lihebi.com");
define_webjump("hebi", "file:////home/hebi/github/wiki-dist/hebi.html");
define_webjump("helium", "file:////home/hebi/github/helium/doc/doxygen/html/index.html")




// 'delete', bound to 'd', can delete a DOM element

define_webjump("icse16", "http://dl.acm.org/citation.cfm?id=2884781&CFID=845161757&CFTOKEN=80603939")
define_webjump("icse15a", "http://dl.acm.org/citation.cfm?id=2818754&CFID=845161757&CFTOKEN=80603939")
define_webjump("icse15b", "http://dl.acm.org/citation.cfm?id=2819009&CFID=845161757&CFTOKEN=80603939")
define_webjump("icse14", "http://dl.acm.org/citation.cfm?id=2568225&CFID=845161757&CFTOKEN=80603939")
define_webjump("icse13", "http://dl.acm.org/citation.cfm?id=2486788&CFID=845161757&CFTOKEN=80603939")
define_webjump("icse12", "http://dl.acm.org/citation.cfm?id=2337223&CFID=845161757&CFTOKEN=80603939")

define_webjump("fse14", "http://dl.acm.org/citation.cfm?id=2635868&picked=prox&CFID=845161757&CFTOKEN=80603939")
define_webjump("fse12", "http://dl.acm.org/citation.cfm?id=2393596&CFID=845161757&CFTOKEN=80603939")

define_webjump("pldi16", "http://dl.acm.org/citation.cfm?id=2908080&CFID=845161757&CFTOKEN=80603939")
define_webjump("pldi15", "http://dl.acm.org/citation.cfm?id=2737924&CFID=845161757&CFTOKEN=80603939")
define_webjump("pldi14", "http://dl.acm.org/citation.cfm?id=2594291&CFID=845161757&CFTOKEN=80603939")
define_webjump("pldi13", "http://dl.acm.org/citation.cfm?id=2491956&CFID=845161757&CFTOKEN=80603939")
define_webjump("pldi12", "http://dl.acm.org/citation.cfm?id=2254064&CFID=845161757&CFTOKEN=80603939")

define_webjump("issta16", "http://dl.acm.org/citation.cfm?id=2931037&CFID=845161757&CFTOKEN=80603939")
define_webjump("issta15", "http://dl.acm.org/citation.cfm?id=2771783&CFID=845161757&CFTOKEN=80603939")
define_webjump("issta14", "http://dl.acm.org/citation.cfm?id=2610384&CFID=845161757&CFTOKEN=80603939")
define_webjump("issta13", "http://dl.acm.org/citation.cfm?id=2483760&CFID=845161757&CFTOKEN=80603939")
define_webjump("issta12", "http://dl.acm.org/citation.cfm?id=2338965&CFID=845161757&CFTOKEN=80603939")


/*******************************
 * other
 *******************************/

url_remoting_fn = load_url_in_new_buffer;

// Enable auto save session and make it load automatically at startup.

// require("session.js");
// session_auto_save_auto_load = true;

// Setup how long in days, history entries are kept before being automatically expired.
// session_pref('browser.history_expire_days', 30);

hints_display_url_panel = true;


// Not working
// require("adblockplus.js");


require('eye-guide.js');
define_key(content_buffer_normal_keymap, "space", "eye-guide-scroll-down");
define_key(content_buffer_normal_keymap, "back_space", "eye-guide-scroll-up");




// Using C-g to unfocus, and ESC to stop-loading

// define_key(content_buffer_normal_keymap, "C-x C-s", "save-page");
// define_key(content_buffer_normal_keymap, "C-x h", "cmd_selectAll");

// define_key(content_buffer_normal_keymap, "C-g", "stop-loading");
define_key(content_buffer_normal_keymap, "C-g", "unfocus");

// define_key(content_buffer_normal_keymap, "escape", "unfocus");
define_key(content_buffer_normal_keymap, "escape", "stop-loading");

// define_key(content_buffer_normal_keymap, "M-escape", "unfocus");

// define_key(content_buffer_normal_keymap, "tab", "browser-focus-next-form-field");



require("clicks-in-new-buffer.js");
// Set to either OPEN_NEW_BUFFER or OPEN_NEW_BUFFER_BACKGROUND
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND; // Now buffers open in background.
// Set to 0 = left mouse, 1 = middle mouse, 2 = right mouse
clicks_in_new_buffer_button = 2; //  Now right mouse follows links in new buffers.

/*******************************
 * Restore
 *******************************/

// I think by the time kill_buffer_hook runs the buffer is gone so I
// patch kill_buffer

var kill_buffer_original = kill_buffer_original || kill_buffer;

var killed_buffers = [];

kill_buffer = function (buffer, force) {
    if (buffer.display_uri_string) {
        killed_buffers.push({url: buffer.display_uri_string,
                             title: buffer.title,
                             history: buffer.web_navigation.sessionHistory});
    }

    kill_buffer_original(buffer,force);
};

interactive("restore-killed-buffer-url", "Loads url from a previously killed buffer",
            function restore_killed_buffer_url (I) {
                if (killed_buffers.length !== 0) {
                    var killed_buffer = yield I.minibuffer.read(
                        $prompt = "Restore killed buffer url:",
                        $completer = new all_word_completer($completions = killed_buffers,
                                                            $get_string = function (x) x.url,
                                                            $get_description = function (x) x.title),
                        $default_completion = killed_buffers[killed_buffers.length - 1],
                        $auto_complete = "url",
                        $auto_complete_initial = true,
                        $auto_complete_delay = 0,
                        $require_match = true
                    );
                    
                    load_url_in_new_buffer(killed_buffer.url);

                    var buf = I.window.buffers.current;
                    buf.web_navigation.sessionHistory = killed_buffer.history;
                    var original_index = buf.web_navigation.sessionHistory.index;
                    buf.web_navigation.gotoIndex(original_index);

                } else {
                    I.window.minibuffer.message("No killed buffer urls");
                }
            });
