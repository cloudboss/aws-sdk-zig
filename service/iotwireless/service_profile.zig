/// Information about a service profile.
pub const ServiceProfile = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The ID of the service profile.
    id: ?[]const u8 = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
