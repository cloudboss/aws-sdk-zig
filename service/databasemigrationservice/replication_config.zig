const ComputeConfig = @import("compute_config.zig").ComputeConfig;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;

/// This object provides configuration information about a serverless
/// replication.
pub const ReplicationConfig = struct {
    /// Configuration parameters for provisioning an DMS serverless replication.
    compute_config: ?ComputeConfig = null,

    /// Indicates whether the replication configuration is read-only. When set to
    /// `true`,
    /// this replication configuration is managed by DMS as part of a zero-ETL
    /// integration and cannot
    /// be modified or deleted directly. You can only modify or delete read-only
    /// replication configurations
    /// through their associated zero-ETL integration.
    is_read_only: ?bool = null,

    /// The Amazon Resource Name (ARN) of this DMS Serverless replication
    /// configuration.
    replication_config_arn: ?[]const u8 = null,

    /// The time the serverless replication config was created.
    replication_config_create_time: ?i64 = null,

    /// The identifier for the `ReplicationConfig` associated with the
    /// replication.
    replication_config_identifier: ?[]const u8 = null,

    /// The time the serverless replication config was updated.
    replication_config_update_time: ?i64 = null,

    /// Configuration parameters for an DMS serverless replication.
    replication_settings: ?[]const u8 = null,

    /// The type of the replication.
    replication_type: ?MigrationTypeValue = null,

    /// The Amazon Resource Name (ARN) of the source endpoint for this DMS
    /// serverless
    /// replication configuration.
    source_endpoint_arn: ?[]const u8 = null,

    /// Additional parameters for an DMS serverless replication.
    supplemental_settings: ?[]const u8 = null,

    /// Table mappings specified in the replication.
    table_mappings: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target endpoint for this DMS
    /// serverless
    /// replication configuration.
    target_endpoint_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_config = "ComputeConfig",
        .is_read_only = "IsReadOnly",
        .replication_config_arn = "ReplicationConfigArn",
        .replication_config_create_time = "ReplicationConfigCreateTime",
        .replication_config_identifier = "ReplicationConfigIdentifier",
        .replication_config_update_time = "ReplicationConfigUpdateTime",
        .replication_settings = "ReplicationSettings",
        .replication_type = "ReplicationType",
        .source_endpoint_arn = "SourceEndpointArn",
        .supplemental_settings = "SupplementalSettings",
        .table_mappings = "TableMappings",
        .target_endpoint_arn = "TargetEndpointArn",
    };
};
