/// Detailed data of the context of the sync blocker.
pub const SyncBlockerContext = struct {
    /// The key for the sync blocker context.
    key: []const u8,

    /// The value of the sync blocker context.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
