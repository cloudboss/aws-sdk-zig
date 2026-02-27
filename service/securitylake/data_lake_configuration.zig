const DataLakeEncryptionConfiguration = @import("data_lake_encryption_configuration.zig").DataLakeEncryptionConfiguration;
const DataLakeLifecycleConfiguration = @import("data_lake_lifecycle_configuration.zig").DataLakeLifecycleConfiguration;
const DataLakeReplicationConfiguration = @import("data_lake_replication_configuration.zig").DataLakeReplicationConfiguration;

/// Provides details of Amazon Security Lake object.
pub const DataLakeConfiguration = struct {
    /// Provides encryption details of Amazon Security Lake object.
    encryption_configuration: ?DataLakeEncryptionConfiguration,

    /// Provides lifecycle details of Amazon Security Lake object.
    lifecycle_configuration: ?DataLakeLifecycleConfiguration,

    /// The Amazon Web Services Regions where Security Lake is automatically
    /// enabled.
    region: []const u8,

    /// Provides replication details of Amazon Security Lake object.
    replication_configuration: ?DataLakeReplicationConfiguration,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .lifecycle_configuration = "lifecycleConfiguration",
        .region = "region",
        .replication_configuration = "replicationConfiguration",
    };
};
