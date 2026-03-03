/// The metadata of a list.
pub const AllowDenyList = struct {
    /// The ARN of the list.
    arn: ?[]const u8 = null,

    /// The time the list was created.
    created_time: ?[]const u8 = null,

    /// The description of the list.
    description: ?[]const u8 = null,

    /// The name of the list.
    name: []const u8,

    /// The time the list was last updated.
    updated_time: ?[]const u8 = null,

    /// The variable type of the list.
    variable_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .name = "name",
        .updated_time = "updatedTime",
        .variable_type = "variableType",
    };
};
