// =============================================================================
// Part of GPP
// Karabiner-Elements Complex Modifications Configuration
// =============================================================================
//
// This Jsonnet file generates Karabiner-Elements complex modifications.
// To generate JSON: jsonnet gpp_for_karabinar.jsonnet -o gpp_for_karabinar.json
//
// =============================================================================

local GPP_HOME = std.extVar('GPP_HOME');

// -----------------------------------------------------------------------------
// Bundle Identifier Groups
// -----------------------------------------------------------------------------
// These are commonly used application groups for condition matching.
// Karabiner uses regex patterns to match bundle identifiers.

/* AI chat applications (ChatGPT, Claude desktop apps, Google Gemini) */
// ChatGPT Desktop App
local chatGptApp = [
  '^com\\.openai\\.chat$',
  '^com\\.openai\\.codex$',
];

// Chat GPT Chrome App
local chatGptChromeApp = [
  // Add your ChatGPT Chrome app ID below
  '^com\\.google\\.Chrome\\.app\\.cadlkienfkclaiaibeoongdcgmdikeeg$',  //ChatGPT(e3Neo)
];

// Claude Desktop App
local claudeApp = [
  '^com\\.anthropic\\.claudefordesktop$',
];

// Google Gemini Desktop App
local geminiApp = [
  '^com\\.google\\.GeminiMacOS$',
];

// Google Gemini Chrome App
local geminiChromeApp = [
  // Add your Google Gemini Chrome app ID below
  '^com\\.google\\.Chrome\\.app\\.kjajbhpgcmkmakfdjmghbhkkkpgbnbbf$',  //Gemini(E4)
  '^com\\.google\\.Chrome\\.app\\.gdfaincndogidkdcdkhapmbffkckdkhn$',  //Gemini(e3Neo)
];

// Google AI Studio Chrome App
local gAIStudioChromeApp = [
  // Add your Google AI Studio Chrome app ID below
  '^com\\.google\\.Chrome\\.app\\.bcmmjkglicliekcndffbfgcfopnidllp$',
];

// Applications to tweak Enter behavior (Shift+Enter vs Cmd+Enter) - mainly for AI chat apps
local tweakEnterApps =
  chatGptApp + chatGptChromeApp + claudeApp + geminiApp + geminiChromeApp + gAIStudioChromeApp;

// Applications to tweak Cmd+N behavior (Shift+Cmd+O) - mainly for Chrome AI apps
local tweakCommandNApps =
  chatGptChromeApp + geminiChromeApp + gAIStudioChromeApp;

/* *****************************************************************************
 * In Remote-Desktop-like applications, keystrokes should be sent to the remote.
 * Therefore, these programs are specified as "unless" condition.
 *******************************************************************************/

// macOS Screen Sharing
local macosScreenSharing = [
  '^com\\.apple\\.ScreenSharing$',
  '^com\\.apple\\.universalcontrol$',
];

// VNC Clients
local vncClients = [
  '^com\\.realvnc\\.vncviewer$',
  '^com\\.tigervnc\\.tigervnc$',
  '^com\\.apple\\.RemoteDesktop$',
];

// Windows RDP clients (subset without macOS Screen Sharing)
local winRdpClients = [
  '^com\\.2X\\.Client\\.Mac$',
  '^com\\.citrix\\.receiver\\.icaviewer',
  '^com\\.itap-mobile\\.qmote$',
  '^com\\.microsoft\\.rdc$',
  '^com\\.microsoft\\.rdc\\.',
  '^com\\.nulana\\.remotixmac$',
  '^com\\.nulana\\.remotixmacwild$',
  '^com\\.OpenText\\.Exceed-TurboX-Client$',
  '^com\\.p5sys\\.jump\\.mac\\.viewer$',
  '^com\\.p5sys\\.jump\\.mac\\.viewer\\.',
  '^com\\.teamviewer\\.TeamViewer$',
  '^com\\.thinomenon\\.RemoteDesktopConnection$',
  '^net\\.sf\\.cord$',
];

// Virtual Machine Monitors
local vmMonitors = [
  '^com\\.parallels\\.desktop$',
  '^com\\.parallels\\.desktop\\.console$',
  '^com\\.parallels\\.vm$',
  '^com\\.parallels\\.winapp\\.',
  '^com\\.utmapp\\.UTM$',
  '^com\\.vmware\\.fusion$',
  '^com\\.vmware\\.horizon$',
  '^com\\.vmware\\.proxyApp\\.',
  '^com\\.vmware\\.view$',
  '^org\\.virtualbox\\.app\\.VirtualBoxVM$',
];

// Terminal emulators
local terminals = [
  '^org\\.alacritty$',  // Alacritty [https://alacritty.org/]
  '^com\\.apple\\.Terminal$',  // Apple Terminal
  '^dev\\.archipelago$',  // Archipelago [https://github.com/npezza93/archipelago/]
  '^org\\.contourterminal\\.Contour$',  // Contour Terminal [https://contour-terminal.org/]
  '^org\\.the-meiers\\.coolterm$',  // CoolTerm [https://freeware.the-meiers.org/]]
  '^org\\.electerm\\.electerm$',  // Electerm [https://electerm.html5beta.com/]
  '^com\\.mitchellh\\.ghostty$',  // Ghostty [https://ghostty.org/docs]
  '^co\\.zeit\\.hyper$',  // Hyper [https://hyper.is/]
  '^com\\.googlecode\\.iterm2$',  // iTerm2 [https://iterm2.com/]
  '^net\\.kovidgoyal\\.kitty$',  // Kitty  [https://sw.kovidgoyal.net/kitty/]
  '^com\\.raphaelamorim\\.rio$',  // Rio Terminal [https://rioterm.com/]
  '^org\\.tabby$',  // Tabby [https://tabby.sh/]
  '^app\\.termora$',  // Termora [https://www.termora.app/]
  '^dev\\.warp\\.Warp',  // Warp Terminal [https://www.warp.dev/]
  '^com\\.github\\.wez\\.wezterm$',  // WezTerm [https://wezterm.org/]
  '^KingToolbox\\.WindTerm$',  // WindTerm [https://kingtoolbox.github.io/]
];

// Web browsers
local webBrowsers = [
  '^org\\.pqrs\\.unknownapp\\.conkeror$',
  '^org\\.mozilla\\.firefox$',
  '^org\\.mozilla\\.firefoxdeveloperedition$',
  '^org\\.mozilla\\.nightly$',
  '^com\\.microsoft\\.Edge',
  '^com\\.microsoft\\.edgemac',
  '^com\\.google\\.Chrome$',
  '^com\\.brave\\.Browser$',
  '^com\\.apple\\.Safari$',
];

// Generic development applications
local developmentApp = [
  '^com\\.microsoft\\.VSCode$',
  '^com\\.microsoft\\.VSCodeInsiders$',
  '^com\\.jetbrains\\.',
  '^org\\.eclipse\\.platform\\.ide$',
  '^org\\.gnu\\.Emacs$',
  '^com\\.qvacua\\.VimR$',  // VimR (GUI for Neovim)
  '^org\\.vim\\.MacVim$',  // MacVim (GUI for Vim)
];

// Windows RDP + VM (for Cortana/Teams workaround)
local winRdpVm = winRdpClients + vmMonitors;

// RDP + VM (for key mappings that should pass through to remote systems)
local allRdpVm = macosScreenSharing + vncClients + winRdpClients + vmMonitors;

// [PC-Style] RDP + VM + Terminals +  Developper app (includes AI Chat app)
local allRdpVmTermDev = allRdpVm + terminals + developmentApp + tweakEnterApps;

// RDP + VM + Terminals + Development Apps + Web Browsers
local allRdpVmTermDevBrowser = allRdpVmTermDev + webBrowsers;

// -----------------------------------------------------------------------------
// Helper Functions for Creating Manipulators
// -----------------------------------------------------------------------------

local keyToKey(fromKey, fromMods, toKey, toMods, condType='', bundleIds=[]) = {
  /** Create a basic key-to-key manipulator */
  type: 'basic',
  from: {
    key_code: fromKey,
    [if fromMods != null then 'modifiers']: fromMods,
  },
  to: [{
    key_code: toKey,
    [if toMods != null && std.length(toMods) > 0 then 'modifiers']: toMods,
  }],
  [if condType != '' then 'conditions']: [{
    type: condType,
    bundle_identifiers: bundleIds,
  }],
};

local modifierToIme(modKey, imeKey, holdDownMs=200, condType='', bundleIds=[]) = {
  /** Create a manipulator for modifier key → IME toggle (single tap → IME, hold → modifier) */
  type: 'basic',
  from: {
    key_code: modKey,
    modifiers: { optional: ['any'] },
  },
  parameters: {
    'basic.to_if_held_down_threshold_milliseconds': holdDownMs,
  },
  to: [{
    key_code: modKey,
    // lazy: true,
  }],
  to_if_held_down: [{ key_code: modKey }],
  to_if_alone: [{ key_code: imeKey }],
  [if condType != '' then 'conditions']: [{
    type: condType,
    bundle_identifiers: bundleIds,
  }],
};

local keyToShell(fromKey, fromMods, shellCmd, condType='frontmost_application_unless', bundleIds=macosScreenSharing) = {
  /** Create a shell command manipulator */
  type: 'basic',
  from: {
    key_code: fromKey,
    [if fromMods != null then 'modifiers']: fromMods,
  },
  to: [{ shell_command: shellCmd }],
  [if condType != '' then 'conditions']: [{
    type: condType,
    bundle_identifiers: bundleIds,
  }],
};

// Create an app launcher manipulator (⌥⌘ + key → open app)
local appLauncher(key, appName, extraMods=[]) = {
  /** Launch app with ⌥⌘ + key unless on macOS Screen Sharing */
  type: 'basic',
  from: {
    key_code: key,
    modifiers: { mandatory: ['command', 'option'] + extraMods },
  },
  to: [{ shell_command: "open -a '%s'" % appName }],
  conditions: [{
    type: 'frontmost_application_unless',
    bundle_identifiers: macosScreenSharing,
  }],
};

local keyToNothing(fromKey, fromMods, condType, bundleIds) = {
  /** Create a "key does nothing" manipulator (for disabling shortcuts) */
  type: 'basic',
  from: {
    key_code: fromKey,
    modifiers: fromMods,
  },
  conditions: [{
    type: condType,
    bundle_identifiers: bundleIds,
  }],
};

local rule(description, manipulators) = {
  /** Create a rule object */
  description: description,
  manipulators: manipulators,
};

local genSeparator(title) =
  local base = '----- [' + title + '] ';
  rule(std.substr(base + std.repeat('-', 100), 0, 100),
       [{ type: 'basic', from: {} }]);

// -----------------------------------------------------------------------------
// Rules Definition
// -----------------------------------------------------------------------------

{
  title: '[GPP] General Purpose Profiles (auto generated from jsonnet)',
  rules: [
    // Separator rule for better visual grouping
    rule(std.substr(std.repeat('-', 100), 0, 100), [{ type: 'basic', from: {} }]),

    // =========================================================================
    // IME Switching Rules
    // =========================================================================
    genSeparator('IME Switching Rules'),

    // Single tap Left Command → 英数, hold → Command (not on RDP/VM)
    rule('[GPP] Single Left Command(⌘) to 英数 key NOT on RDC/VM', [
      modifierToIme('left_command',
                    'japanese_eisuu',
                    200,
                    'frontmost_application_unless',
                    allRdpVm),
    ]),

    // Single tap Right Command → かな, hold → Command (not on RDP/VM)
    rule('[GPP] Single Right Command(⌘) to かな key NOT on RDC/VM', [
      modifierToIme('right_command',
                    'japanese_kana',
                    200,
                    'frontmost_application_unless',
                    allRdpVm),
    ]),

    // Single tap Left Option → 英数, hold → Option (no restrictions)
    rule('[GPP] Single Left Option(⌥) to 英数 mode (w/o restrictions)', [
      modifierToIme('left_option', 'japanese_eisuu', 100),
    ]),

    // Single tap Right Option → かな, hold → Option (no restrictions)
    rule('[GPP] Single Right Option(⌥) to かな mode (w/o restrictions)', [
      modifierToIme('right_option', 'japanese_kana', 100),
    ]),

    // =========================================================================
    // Option Key Remappings
    // =========================================================================
    genSeparator('Option Key Remappings'),

    // Option+Enter → Cmd+Enter (not on RDP/VM)
    rule('[GPP] ⌥⏎ to ⌘⏎ NOT on RDC/VM', [
      keyToKey('return_or_enter',
               { mandatory: ['option'] },
               'return_or_enter',
               ['left_command'],
               'frontmost_application_unless',
               macosScreenSharing),
    ]),

    // Option+C → Cmd+C (not on RDP/VM)
    rule('[GPP] ⌥C to ⌘C', [
      keyToKey('c',
               { mandatory: ['option'] },
               'c',
               ['left_command'],
               'frontmost_application_unless',
               macosScreenSharing),
    ]),

    // Option+X → Cmd+X (not on RDP/VM)
    rule('[GPP] ⌥X to ⌘X NOT on RDC/VM', [
      keyToKey('x',
               { mandatory: ['option'] },
               'x',
               ['left_command'],
               'frontmost_application_unless',
               macosScreenSharing),
    ]),

    // Option+V → Cmd+V (not on RDP/VM)
    rule('[GPP] ⌥V to ⌘V NOT on RDC/VM', [
      keyToKey('v',
               { mandatory: ['option'] },
               'v',
               ['left_command'],
               'frontmost_application_unless',
               macosScreenSharing),
    ]),

    // Option+D → Cmd+Delete (forward delete word)
    rule('[GPP] ⌥d to ⌘⌦ (forward delete word) NOT on RDC/VM', [
      keyToKey('d',
               { mandatory: ['option'] },
               'delete_forward',
               ['left_command'],
               'frontmost_application_unless',
               macosScreenSharing),
    ]),

    // =========================================================================
    // CapsLock Remapping
    // =========================================================================
    genSeparator('CapsLock Remapping'),

    // CapsLock → Control (hold) / Escape (tap) - unless Apple Internal Keyboard
    rule('[GPP] Caps -> Ctrl (hold) / Escape (tap) (unless Apple Internal Keyboard)', [
      {
        description: 'CapsLock -> Esc(click) | Control(hold)',
        type: 'basic',
        from: {
          key_code: 'caps_lock',
          modifiers: { optional: ['any'] },
        },
        to: [{
          key_code: 'right_control',
          lazy: true,
        }],
        to_if_alone: [{ key_code: 'escape' }],
        conditions: [{
          description: "Apply if it isn't Apple Internal Keyboard / Trackpad",
          type: 'device_unless',
          identifiers: [{
            description: 'Apple Internal Keyboard (MacBook Pro Retina / JIS)',
            vendor_id: 1452,
            product_id: 612,
            is_keyboard: true,
          }],
        }],
      },
    ]),

    // CapsLock → Hyper (hold) / Escape (tap) - unless Apple Internal Keyboard
    rule('[GPP] Caps -> Hyper (hold) / Escape (tap) (unless Apple Internal Keyboard)', [
      {
        description: 'CapsLock -> Esc(click) | Hyper(hold)',
        type: 'basic',
        from: {
          key_code: 'caps_lock',
          modifiers: { optional: ['any'] },
        },
        to: [{
          key_code: 'right_shift',
          lazy: true,
          modifiers: ['right_command', 'right_control', 'right_option'],
        }],
        to_if_alone: [{ key_code: 'escape' }],
        conditions: [{
          description: "Apply if it isn't Apple Internal Keyboard / Trackpad",
          type: 'device_unless',
          identifiers: [{
            description: 'Apple Internal Keyboard (MacBook Pro Retina / JIS)',
            vendor_id: 1452,
            product_id: 612,
            is_keyboard: true,
          }],
        }],
      },
    ]),

    // =========================================================================
    // Mouse Button Mapping
    // =========================================================================
    genSeparator('Mouse Button Mapping'),

    // Mouse button 5 → Dictionary lookup (Ctrl+Cmd+D)
    rule('[GPP] (OBSOLETE?) Mouse button 5 to Lookup dictionary (⌃⌘D)', [
      {
        type: 'basic',
        from: {
          pointing_button: 'button5',
          modifiers: { optional: ['caps_lock'] },
        },
        to: [{
          key_code: 'd',
          modifiers: ['control', 'command'],
        }],
        conditions: [{
          type: 'frontmost_application_unless',
          bundle_identifiers: macosScreenSharing,
        }],
      },
    ]),

    // =========================================================================
    // Keypad Key Customizations
    // =========================================================================
    genSeparator('Keypad Key Customizations'),

    // Keypad period → 00 (double zero)
    rule('[GPP] Convert Period on Keypad → 00', [
      {
        type: 'basic',
        from: { key_code: 'keypad_period' },
        to: [
          { key_code: 'keypad_0' },
          { key_code: 'keypad_0' },
        ],
      },
    ]),

    // =========================================================================
    // AI Chat App Customizations
    // =========================================================================
    genSeparator('AI Chat App Customizations'),

    // Enter → Shift+Enter, Cmd+Enter → Enter on ChatGPT, Claude and Gemini
    // (Swap newline and send behaviors)
    rule('[GPP] Convert ⏎ to ⇧⏎ and ⌘⏎ to ⏎ on All AI Chat Apps', [
      {
        type: 'basic',
        from: { key_code: 'return_or_enter' },
        to: [{ key_code: 'return_or_enter', modifiers: ['left_shift'] }],
        conditions: [{
          type: 'frontmost_application_if',
          bundle_identifiers: tweakEnterApps,
        }],
      },
      {
        type: 'basic',
        from: {
          key_code: 'return_or_enter',
          modifiers: { mandatory: ['command'] },
        },
        to: [{ key_code: 'return_or_enter' }],
        conditions: [{
          type: 'frontmost_application_if',
          bundle_identifiers: tweakEnterApps,
        }],
      },
    ]),

    // Cmd+N → Shift+Cmd+O on ChatGPT, Claude Desktop, Gemini Chrome App
    rule('[GPP] Convert ⌘N to ⇧⌘O on Chrome AI Apps', [
      keyToKey('n',
               { mandatory: ['command'] },
               'o',
               ['left_command', 'left_shift'],
               'frontmost_application_if',
               tweakCommandNApps),
    ]),

    // =========================================================================
    // iTerm2 Customizations
    // =========================================================================
    genSeparator('iTerm2 Customizations'),

    // Cmd+D → Option+D on iTerm2 (word deletion instead of split pane)
    rule('[GPP][iTerm2] ⌘D to ⌥D (word deletion)', [
      keyToKey('d',
               { mandatory: ['command'] },
               'd',
               ['left_option'],
               'frontmost_application_if',
               ['^com\\.googlecode\\.iterm2']),
    ]),

    // Disable Cmd+R on iTerm2 (prevent accidental terminal reset)
    rule('[GPP][iTerm2] (OBSOLETE) Ignore ⌘R(reset terminal)', [
      keyToNothing('r',
                   { mandatory: ['command'] },
                   'frontmost_application_if',
                   ['^com\\.googlecode\\.iterm2']),
    ]),

    // Disable Cmd+K on iTerm2 (prevent accidental buffer clear)
    rule('[GPP][iTerm2] (OBSOLETE) Ignore ⌘K (clear buffer)', [
      keyToNothing('k',
                   { mandatory: ['command'] },
                   'frontmost_application_if',
                   ['^com\\.googlecode\\.iterm2']),
    ]),

    // =========================================================================
    // Windows RDP/VM Specific
    // =========================================================================
    genSeparator('Windows RDP/VM Specific'),

    // Cmd+C → Ctrl+C on Windows RDP/VM (to avoid Cortana/Teams shortcut)
    rule('[GPP] ⌘C to ⌃C on RDP/VM console (avoid Cortana/Teams on Windows 10/11)', [
      keyToKey('c',
               { mandatory: ['command'] },
               'c',
               ['control'],
               'frontmost_application_if',
               winRdpVm),
    ]),

    // =========================================================================
    // Finder Specific
    // =========================================================================
    genSeparator('Finder Specific'),

    // F2 → Enter on Finder (PC-style rename)
    rule('[GPP][PC-Style][on Finder] Use F2 as Rename', [
      keyToKey('f2',
               null,
               'return_or_enter',
               [],
               'frontmost_application_if',
               ['^com.apple.finder']),
    ]),

    // Delete key → Cmd+Delete on Finder (move to trash)
    rule('[GPP][PC-Style][on Finder] Del key to move into Trash on Finder', [
      keyToKey('delete_forward',
               null,
               'delete_or_backspace',
               ['left_command'],
               'frontmost_application_if',
               ['^com.apple.finder']),
    ]),

    // =========================================================================
    // PC-Style Shortcuts
    // =========================================================================
    genSeparator('PC-Style Shortcuts (For Browsers)'),

    // Ctrl+F/K/R/T → Cmd+F/K/R/T on Browsers
    rule('[GPP][PC-Style][on Browser] ⌃F/K/R/T', [
      keyToKey('f',
               { mandatory: ['control'] },
               'f',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
      keyToKey('k',
               { mandatory: ['control'] },
               'k',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
      keyToKey('r',
               { mandatory: ['control'] },
               'r',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
      keyToKey('t',
               { mandatory: ['control'] },
               't',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
    ]),

    // Alt+Left/Right → Cmd+Left/Right on Browsers (Back/Forward)
    rule('[GPP][PC-Style][on Browser] Back/Forward (⌥←/→)', [
      keyToKey('left_arrow',
               { mandatory: ['option'] },
               'left_arrow',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
      keyToKey('right_arrow',
               { mandatory: ['option'] },
               'right_arrow',
               ['left_command'],
               'frontmost_application_if',
               webBrowsers),
    ]),

    // Ctrl+Left/Right → Option+Arrow keys (word move) (not on RDP/VM/Term/Dev)
    rule('[GPP][PC-Style] ⌃←/→ to ⌥←/→ (word move) NOT on RDC/VM/Term/Dev', [
      keyToKey('left_arrow',
               { mandatory: ['control'] },
               'left_arrow',
               ['left_option'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      keyToKey('right_arrow',
               { mandatory: ['control'] },
               'right_arrow',
               ['left_option'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+Up/Down → Cmd+Up/Down (Top/Bottom of document) (not on RDP/VM/Term/Dev)
    rule('[GPP][PC-Style] ⌃↑/↓ to ⌘↑/↓ (top/bottom of document) NOT on RDC/VM/Term/Dev', [
      keyToKey('up_arrow',
               { mandatory: ['control'] },
               'up_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      keyToKey('down_arrow',
               { mandatory: ['control'] },
               'down_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+T → Cmd+T (New Tab)
    rule('[GPP][PC-Style] New Tab (⌃t) NOT on RDC/VM/Term/Dev)', [
      keyToKey('t',
               { mandatory: ['control'], optional: ['shift'] },
               't',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+C/V/X → Cmd+C/V/X (not on RDP/VM/Terminal/Dev/etc.)
    rule('[GPP][PC-Style] Enable PC-Style Copy/Paste/Cut(⌃X/C/V → ⌘X/C/V) NOT on RDC/VM/Term/Dev', [
      keyToKey('c',
               { mandatory: ['control'] },
               'c',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      keyToKey('v',
               { mandatory: ['control'] },
               'v',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      keyToKey('x',
               { mandatory: ['control'] },
               'x',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Shift+Insert → Cmd+V (paste for JIS keyboard)
    rule('[GPP][PC-Style] Shift+Insert to paste (for JIS keyboard)', [
      keyToKey('insert',
               { mandatory: ['shift'] },
               'v',
               ['left_command']),
    ]),

    // Ctrl+[Shift]+Z → Cmd+[Shift]+Z (Undo)
    rule('[GPP][PC-Style] Undo (⌃z → ⌘z) NOT on RDC/VM/Term/Dev', [
      keyToKey('z',
               { mandatory: ['control'], optional: ['shift'] },
               'z',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+Y → Shift+Cmd+Z (Redo)
    rule('[GPP][PC-Style] Redo(^y → ⇧⌘z) NOT on RDC/VM/Term/Dev', [
      keyToKey('y',
               { mandatory: ['control'] },
               'z',
               ['left_command', 'left_shift'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Home/End key mappings with complex conditions
    rule('[GPP][PC-Style] Home/End with complex conditions', [
      // Home → Cmd+Left (line start) - not on RDP/VM/Terminal/Browser
      keyToKey('home',
               { optional: ['shift'] },
               'left_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDevBrowser),
      // Home → Ctrl+A (line start) - on browsers only
      keyToKey('home',
               { optional: ['shift'] },
               'a',
               ['left_control'],
               'frontmost_application_if',
               webBrowsers),
      // Ctrl+Home → Cmd+Up (document start)
      keyToKey('home',
               { mandatory: ['control'], optional: ['shift'] },
               'up_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDevBrowser),
      // End → Cmd+Right (line end) - not on RDP/VM/Terminal/Browser
      keyToKey('end',
               { optional: ['shift'] },
               'right_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDevBrowser),
      // End → Ctrl+E (line end) - on browsers only
      keyToKey('end',
               { optional: ['shift'] },
               'e',
               ['left_control'],
               'frontmost_application_if',
               webBrowsers),
      // Ctrl+End → Cmd+Down (document end)
      keyToKey('end',
               { mandatory: ['control'], optional: ['shift'] },
               'down_arrow',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+R / F5 → Cmd+R (Reload)
    rule('[GPP][PC-Style] Reload(F5, ⌃R) NOT on RDC/VM/Term/Dev)', [
      keyToKey('r',
               { mandatory: ['control'], optional: ['shift'] },
               'r',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      keyToKey('f5',
               { optional: ['any'] },
               'r',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+F/G → Cmd+F/G (Find)
    rule('[GPP][PC-Style] Find (⌃f/g → ⌘f/g) NOT on RDC/VM/Term/Dev)', [
      // Find
      keyToKey('f',
               { mandatory: ['control'] },
               'f',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
      // Find Next
      keyToKey('g',
               { mandatory: ['control'], optional: ['shift'] },
               'g',
               ['left_command'],
               'frontmost_application_unless',
               allRdpVmTermDev),
    ]),

    // Ctrl+Shift+Esc → Open Activity Monitor (like Windows Task Manager)
    rule('[GPP][PC-Style] ⌃⇧Esc Opens Activity Monitor NOT on RDC/VM', [
      keyToShell('escape',
                 { mandatory: ['control', 'shift'] },
                 "open -a 'Activity Monitor.app'",
                 bundleIds=allRdpVm),
    ]),

    // Ctrl+Backspace → Option+Backspace (delete word)
    rule('[GPP][PC-Style] ⌃Del/Bs (⌃⌫ → ⌥⌫) (delete word) NOT on RDC/VM/Term/Dev/Browser', [
      keyToKey('delete_or_backspace',
               { mandatory: ['control'] },
               'delete_or_backspace',
               ['option'],
               'frontmost_application_unless',
               allRdpVmTermDevBrowser),
    ]),

    // =========================================================================
    // Application Launchers
    // =========================================================================
    genSeparator('Application Launchers'),

    // Cmd+E → Open Finder (not on RDP/VM)
    rule('[GPP] Opens <Finder> by ⌘E (if not on RDC/VM)', [
      {
        type: 'basic',
        from: {
          key_code: 'e',
          modifiers: { mandatory: ['command'] },
        },
        to: [{
          shell_command: "osascript -e 'tell application \"Finder\"' -e 'if (count of windows) is 0 then' -e 'make new Finder window to folder ((path to home folder) as text)' -e 'else' -e 'set frontmost to true' -e 'end if' -e 'activate' -e 'end tell'",
        }],
        conditions: [{
          type: 'frontmost_application_unless',
          bundle_identifiers: allRdpVm,
        }],
      },
    ]),

    // Option+Cmd+, → System Preferences
    rule('[GPP] Start <System Preferences> by ⌥⌘,', [
      keyToShell('comma',
                 { mandatory: ['command', 'option'] },
                 "open -a 'System Preferences'"),
    ]),

    // Option+Cmd+C → ChatGPT Desktop or ChatGPT Chrome App (duplicate shortcut - only one will work)
    rule('[GPP] Start <ChatGPT Desktop> or <ChatGPT Chrome App> by ⌥⌘C', [
      appLauncher('c', 'ChatGPT'),
    ]),

    // Ctrl+Option+Cmd+C → Claude Desktop
    rule('[GPP] Start <Claude Desktop> by ⌘⌃⌥C', [
      keyToShell('c',
                 { mandatory: ['command', 'control', 'option'] },
                 "open -a 'Claude'"),
    ]),

    // Ctrl+Option+C → Gemini Desktop
    rule('[GPP] Start <Google Gemini Desktop> by ⌃⌥C', [
      keyToShell('c',
                 { mandatory: ['control', 'option'] },
                 "open -a 'Gemini'"),
    ]),

    // Ctrl+Option+C → Gemini Chrome App
    rule('[GPP] Start <Google Gemini Chrome App> by ⌃⌥C', [
      keyToShell('c',
                 { mandatory: ['control', 'option'] },
                 "open -a 'Google Gemini'"),
    ]),

    // Ctrl+Cmd+C → Calculator
    rule('[GPP] Start <Calculator> by ⌃⌘C', [
      keyToShell('c',
                 { mandatory: ['command', 'control'] },
                 "open -a 'Calculator'"),
    ]),

    // Option+Cmd+D → Discord Canary
    rule('[GPP] Start <Discord> by ⌥⌘D', [
      appLauncher('d', 'Discord Canary'),
    ]),

    // Option+Cmd+D → DeepL (duplicate shortcut - only one will work)
    rule('[GPP] Start <DeepL> by ⌥⌘D', [
      appLauncher('d', 'DeepL'),
    ]),

    // Option+Cmd+F → Firefox
    rule('[GPP] Start <Firefox> by ⌥⌘F', [
      appLauncher('f', 'Firefox'),
    ]),

    // Option+Cmd+G → Google Chrome
    rule('[GPP] Start <Google Chrome> by ⌥⌘G', [
      appLauncher('g', 'Google Chrome'),
    ]),

    // Option+Cmd+G → Chromium (duplicate shortcut)
    rule('[GPP] Start <Chromium> by ⌥⌘G', [
      appLauncher('g', 'Chromium'),
    ]),

    // Option+Cmd+L → LINE
    rule('[GPP] Start <LINE> by ⌥⌘L', [
      appLauncher('l', 'LINE'),
    ]),

    // Option+Cmd+R → Remember The Milk
    rule('[GPP] Start <RtM> by ⌥⌘R', [
      appLauncher('r', 'Remember The Milk'),
    ]),

    // Option+Cmd+S → Spotify
    rule('[GPP] Start <Spotify> by ⌥⌘S', [
      appLauncher('s', 'Spotify'),
    ]),

    // Option+Shift+Cmd+S → Slack
    rule('[GPP] Start <Slack> by ⌥⇧⌘S', [
      keyToShell('s',
                 { mandatory: ['command', 'option', 'shift'] },
                 "open -a 'Slack'"),
    ]),

    // Option+Cmd+T → iTerm
    rule('[GPP] Start <iTerm2> by ⌥⌘T', [
      appLauncher('t', 'iTerm'),
    ]),

    // Option+Cmd+T → Ghostty
    rule('[GPP] Start <Ghostty> by ⌥⌘T', [
      appLauncher('t', 'Ghostty'),
    ]),

    // Option+Cmd+T → Ghostty
    rule('[GPP] Start <Ghostty> by ⌥⌘T (AppleScript)', [
      {
        type: 'basic',
        from: {
          key_code: 't',
          modifiers: { mandatory: ['command', 'option'] },
        },
        to: [{
          shell_command: 'osascript ' + GPP_HOME + '/settings/apps/ghostty/tools/open_as_ghostty_tab.applescript',
        }],
        conditions: [{
          type: 'frontmost_application_unless',
          bundle_identifiers: allRdpVm,
        }],
      },
    ]),

    // Option+Cmd+V → Visual Studio Code
    rule('[GPP] Start <VSCode> by ⌥⌘V', [
      appLauncher('v', 'Visual Studio Code'),
    ]),

    // Option+Cmd+M → Spark Desktop
    rule('[GPP] Start <Spark Desktop> by ⌥⌘M', [
      appLauncher('m', 'Spark Desktop'),
    ]),

  ],
}
