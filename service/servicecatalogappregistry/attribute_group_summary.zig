/// Summary of a Amazon Web Services Service Catalog AppRegistry attribute
/// group.
pub const AttributeGroupSummary = struct {
    /// The Amazon resource name (ARN) that specifies the attribute group across
    /// services.
    arn: ?[]const u8 = null,

    /// The service principal that created the attribute group.
    created_by: ?[]const u8 = null,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was
    /// created.
    creation_time: ?i64 = null,

    /// The description of the attribute group that the user provides.
    description: ?[]const u8 = null,

    /// The globally unique attribute group identifier of the attribute group.
    id: ?[]const u8 = null,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was last
    /// updated. This time is the same as the creationTime for a newly created
    /// attribute group.
    last_update_time: ?i64 = null,

    /// The name of the attribute group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_by = "createdBy",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .name = "name",
    };
};
