/// The name identifier.
pub const NameIdentifier = struct {
    /// The name in the name identifier.
    name: ?[]const u8,

    /// The namespace in the name identifier.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
    };
};
