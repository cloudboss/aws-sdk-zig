/// Contains details about a newly created relationship.
pub const CreateRelationshipDetail = struct {
    /// The Amazon Resource Name (ARN) of the created relationship.
    arn: ?[]const u8 = null,

    /// The unique identifier of the created relationship.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};
