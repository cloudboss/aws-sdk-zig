/// Defines the key-value pairs to make them available inside the cluster.
pub const KxCommandLineArgument = struct {
    /// The name of the key.
    key: ?[]const u8 = null,

    /// The value of the key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
