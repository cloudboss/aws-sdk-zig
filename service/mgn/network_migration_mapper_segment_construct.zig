const aws = @import("aws");

/// Represents a construct within a mapper segment. A construct is an individual
/// infrastructure component such as a VPC, subnet, security group, route table,
/// or other network resource that is part of the network migration.
pub const NetworkMigrationMapperSegmentConstruct = struct {
    /// The unique identifier of the construct.
    construct_id: ?[]const u8 = null,

    /// The type of the construct, such as VPC, subnet, security group, or route
    /// table.
    construct_type: ?[]const u8 = null,

    /// The timestamp when the construct was created.
    created_at: ?i64 = null,

    /// A description of the construct.
    description: ?[]const u8 = null,

    /// The logical identifier for the construct in the infrastructure code.
    logical_id: ?[]const u8 = null,

    /// The name of the construct.
    name: ?[]const u8 = null,

    /// The properties and configuration of the construct.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the construct was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .construct_id = "constructID",
        .construct_type = "constructType",
        .created_at = "createdAt",
        .description = "description",
        .logical_id = "logicalID",
        .name = "name",
        .properties = "properties",
        .updated_at = "updatedAt",
    };
};
