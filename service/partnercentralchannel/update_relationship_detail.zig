/// Contains details about an updated relationship.
pub const UpdateRelationshipDetail = struct {
    /// The Amazon Resource Name (ARN) of the updated relationship.
    arn: ?[]const u8 = null,

    /// The updated display name of the relationship.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the updated relationship.
    id: ?[]const u8 = null,

    /// The new revision number of the relationship.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .display_name = "displayName",
        .id = "id",
        .revision = "revision",
    };
};
