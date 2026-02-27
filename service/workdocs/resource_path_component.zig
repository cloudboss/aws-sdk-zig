/// Describes the resource path.
pub const ResourcePathComponent = struct {
    /// The ID of the resource path.
    id: ?[]const u8,

    /// The name of the resource path.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
