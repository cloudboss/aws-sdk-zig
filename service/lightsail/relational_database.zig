const RelationalDatabaseHardware = @import("relational_database_hardware.zig").RelationalDatabaseHardware;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const RelationalDatabaseEndpoint = @import("relational_database_endpoint.zig").RelationalDatabaseEndpoint;
const PendingMaintenanceAction = @import("pending_maintenance_action.zig").PendingMaintenanceAction;
const PendingModifiedRelationalDatabaseValues = @import("pending_modified_relational_database_values.zig").PendingModifiedRelationalDatabaseValues;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes a database.
pub const RelationalDatabase = struct {
    /// The Amazon Resource Name (ARN) of the database.
    arn: ?[]const u8 = null,

    /// A Boolean value indicating whether automated backup retention is enabled for
    /// the
    /// database.
    backup_retention_enabled: ?bool = null,

    /// The certificate associated with the database.
    ca_certificate_identifier: ?[]const u8 = null,

    /// The timestamp when the database was created. Formatted in Unix time.
    created_at: ?i64 = null,

    /// The database software (for example, `MySQL`).
    engine: ?[]const u8 = null,

    /// The database engine version (for example, `5.7.23`).
    engine_version: ?[]const u8 = null,

    /// Describes the hardware of the database.
    hardware: ?RelationalDatabaseHardware = null,

    /// The latest point in time to which the database can be restored. Formatted in
    /// Unix
    /// time.
    latest_restorable_time: ?i64 = null,

    /// The Region name and Availability Zone where the database is located.
    location: ?ResourceLocation = null,

    /// The name of the master database created when the Lightsail database resource
    /// is
    /// created.
    master_database_name: ?[]const u8 = null,

    /// The master endpoint for the database.
    master_endpoint: ?RelationalDatabaseEndpoint = null,

    /// The master user name of the database.
    master_username: ?[]const u8 = null,

    /// The unique name of the database resource in Lightsail.
    name: ?[]const u8 = null,

    /// The status of parameter updates for the database.
    parameter_apply_status: ?[]const u8 = null,

    /// Describes the pending maintenance actions for the database.
    pending_maintenance_actions: ?[]const PendingMaintenanceAction = null,

    /// Describes pending database value modifications.
    pending_modified_values: ?PendingModifiedRelationalDatabaseValues = null,

    /// The daily time range during which automated backups are created for the
    /// database (for
    /// example, `16:00-16:30`).
    preferred_backup_window: ?[]const u8 = null,

    /// The weekly time range during which system maintenance can occur on the
    /// database.
    ///
    /// In the format `ddd:hh24:mi-ddd:hh24:mi`. For example,
    /// `Tue:17:00-Tue:17:30`.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A Boolean value indicating whether the database is publicly accessible.
    publicly_accessible: ?bool = null,

    /// The blueprint ID for the database. A blueprint describes the major engine
    /// version of a
    /// database.
    relational_database_blueprint_id: ?[]const u8 = null,

    /// The bundle ID for the database. A bundle describes the performance
    /// specifications for your
    /// database.
    relational_database_bundle_id: ?[]const u8 = null,

    /// The Lightsail resource type for the database (for example,
    /// `RelationalDatabase`).
    resource_type: ?ResourceType = null,

    /// Describes the secondary Availability Zone of a high availability database.
    ///
    /// The secondary database is used for failover support of a high availability
    /// database.
    secondary_availability_zone: ?[]const u8 = null,

    /// Describes the current state of the database.
    state: ?[]const u8 = null,

    /// The support code for the database. Include this code in your email to
    /// support when you
    /// have questions about a database in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8 = null,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .arn = "arn",
        .backup_retention_enabled = "backupRetentionEnabled",
        .ca_certificate_identifier = "caCertificateIdentifier",
        .created_at = "createdAt",
        .engine = "engine",
        .engine_version = "engineVersion",
        .hardware = "hardware",
        .latest_restorable_time = "latestRestorableTime",
        .location = "location",
        .master_database_name = "masterDatabaseName",
        .master_endpoint = "masterEndpoint",
        .master_username = "masterUsername",
        .name = "name",
        .parameter_apply_status = "parameterApplyStatus",
        .pending_maintenance_actions = "pendingMaintenanceActions",
        .pending_modified_values = "pendingModifiedValues",
        .preferred_backup_window = "preferredBackupWindow",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .publicly_accessible = "publiclyAccessible",
        .relational_database_blueprint_id = "relationalDatabaseBlueprintId",
        .relational_database_bundle_id = "relationalDatabaseBundleId",
        .resource_type = "resourceType",
        .secondary_availability_zone = "secondaryAvailabilityZone",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
