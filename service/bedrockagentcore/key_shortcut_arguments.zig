/// Arguments for a key shortcut action.
pub const KeyShortcutArguments = struct {
    /// The key combination to press (for example, `["ctrl", "s"]`). Maximum 5 keys.
    keys: []const []const u8,

    pub const json_field_names = .{
        .keys = "keys",
    };
};
