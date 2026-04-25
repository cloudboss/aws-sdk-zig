/// Arguments for a key press action.
pub const KeyPressArguments = struct {
    /// The key name to press (for example, `enter`, `tab`, `escape`).
    key: []const u8,

    /// The number of times to press the key. Valid range: 1–100. Defaults to 1.
    presses: ?i32 = null,

    pub const json_field_names = .{
        .key = "key",
        .presses = "presses",
    };
};
