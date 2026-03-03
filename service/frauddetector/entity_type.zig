/// The entity type details.
pub const EntityType = struct {
    /// The entity type ARN.
    arn: ?[]const u8 = null,

    /// Timestamp of when the entity type was created.
    created_time: ?[]const u8 = null,

    /// The entity type description.
    description: ?[]const u8 = null,

    /// Timestamp of when the entity type was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The entity type name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
