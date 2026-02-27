const aws = @import("aws");

/// Represents a Amazon Web Services Service Catalog AppRegistry attribute group
/// that is rich metadata which describes an application and its components.
pub const AttributeGroup = struct {
    /// The Amazon resource name (ARN) that specifies the attribute group across
    /// services.
    arn: ?[]const u8,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was
    /// created.
    creation_time: ?i64,

    /// The description of the attribute group that the user provides.
    description: ?[]const u8,

    /// The globally unique attribute group identifier of the attribute group.
    id: ?[]const u8,

    /// The ISO-8601 formatted timestamp of the moment the attribute group was last
    /// updated. This time is the same as the creationTime for a newly created
    /// attribute group.
    last_update_time: ?i64,

    /// The name of the attribute group.
    name: ?[]const u8,

    /// Key-value pairs you can use to associate with the attribute group.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .tags = "tags",
    };
};
