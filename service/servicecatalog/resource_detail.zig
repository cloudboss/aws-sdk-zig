/// Information about a resource.
pub const ResourceDetail = struct {
    /// The ARN of the resource.
    arn: ?[]const u8,

    /// The creation time of the resource.
    created_time: ?i64,

    /// The description of the resource.
    description: ?[]const u8,

    /// The identifier of the resource.
    id: ?[]const u8,

    /// The name of the resource.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .created_time = "CreatedTime",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
