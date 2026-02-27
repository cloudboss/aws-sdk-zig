/// Updated properties
/// for the HTTP namespace.
pub const HttpNamespaceChange = struct {
    /// An updated
    /// description for the HTTP namespace.
    description: []const u8,

    pub const json_field_names = .{
        .description = "Description",
    };
};
