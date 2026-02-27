/// A structure containing some information about a group.
pub const GroupSummary = struct {
    /// The ARN of the group.
    arn: ?[]const u8,

    /// The unique ID of the group.
    id: ?[]const u8,

    /// The name of the group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
