const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes a database snapshot.
pub const RelationalDatabaseSnapshot = struct {
    /// The Amazon Resource Name (ARN) of the database snapshot.
    arn: ?[]const u8 = null,

    /// The timestamp when the database snapshot was created.
    created_at: ?i64 = null,

    /// The software of the database snapshot (for example, `MySQL`)
    engine: ?[]const u8 = null,

    /// The database engine version for the database snapshot (for example,
    /// `5.7.23`).
    engine_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the database from which the database
    /// snapshot was
    /// created.
    from_relational_database_arn: ?[]const u8 = null,

    /// The blueprint ID of the database from which the database snapshot was
    /// created. A blueprint
    /// describes the major engine version of a database.
    from_relational_database_blueprint_id: ?[]const u8 = null,

    /// The bundle ID of the database from which the database snapshot was created.
    from_relational_database_bundle_id: ?[]const u8 = null,

    /// The name of the source database from which the database snapshot was
    /// created.
    from_relational_database_name: ?[]const u8 = null,

    /// The Region name and Availability Zone where the database snapshot is
    /// located.
    location: ?ResourceLocation = null,

    /// The name of the database snapshot.
    name: ?[]const u8 = null,

    /// The Lightsail resource type.
    resource_type: ?ResourceType = null,

    /// The size of the disk in GB (for example, `32`) for the database
    /// snapshot.
    size_in_gb: ?i32 = null,

    /// The state of the database snapshot.
    state: ?[]const u8 = null,

    /// The support code for the database snapshot. Include this code in your email
    /// to support
    /// when you have questions about a database snapshot in Lightsail. This code
    /// enables our
    /// support team to look up your Lightsail information more easily.
    support_code: ?[]const u8 = null,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .engine = "engine",
        .engine_version = "engineVersion",
        .from_relational_database_arn = "fromRelationalDatabaseArn",
        .from_relational_database_blueprint_id = "fromRelationalDatabaseBlueprintId",
        .from_relational_database_bundle_id = "fromRelationalDatabaseBundleId",
        .from_relational_database_name = "fromRelationalDatabaseName",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
        .size_in_gb = "sizeInGb",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
