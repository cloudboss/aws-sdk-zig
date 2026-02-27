/// The context for a specific sync blocker.
pub const SyncBlockerContext = struct {
    /// The key provided for a context key-value pair for a specific sync blocker.
    key: []const u8,

    /// The value provided for a context key-value pair for a specific sync blocker.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
