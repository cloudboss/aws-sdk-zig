/// The name identifier.
pub const NameIdentifier = struct {
    /// The name in the name identifier.
    name: ?[]const u8 = null,

    /// The namespace in the name identifier.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
    };
};
