/// A key-value filter pair used in container association monitoring
/// configurations to narrow which containers
/// are tracked.
pub const ContainerAttribute = struct {
    /// The attribute key to filter on.
    key: []const u8,

    /// The attribute value to match.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
