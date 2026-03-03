/// Information about a resource.
pub const ResourceDetail = struct {
    /// The ARN of the resource.
    arn: ?[]const u8 = null,

    /// The creation time of the resource.
    created_time: ?i64 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The identifier of the resource.
    id: ?[]const u8 = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
