const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const DataTieringStatus = @import("data_tiering_status.zig").DataTieringStatus;

/// Represents a copy of an entire cluster as of the time when the snapshot was
/// taken.
pub const Snapshot = struct {
    /// The ARN (Amazon Resource Name) of the snapshot.
    arn: ?[]const u8 = null,

    /// The configuration of the cluster from which the snapshot was taken
    cluster_configuration: ?ClusterConfiguration = null,

    /// Enables data tiering. Data tiering is only supported for clusters using the
    /// r6gd node type.
    /// This parameter must be set when using r6gd nodes. For more information, see
    /// [Data
    /// tiering](https://docs.aws.amazon.com/memorydb/latest/devguide/data-tiering.html).
    data_tiering: ?DataTieringStatus = null,

    /// The ID of the KMS key used to encrypt the snapshot.
    kms_key_id: ?[]const u8 = null,

    /// The name of the snapshot
    name: ?[]const u8 = null,

    /// Indicates whether the snapshot is from an automatic backup (automated) or
    /// was created manually (manual).
    source: ?[]const u8 = null,

    /// The status of the snapshot. Valid values: creating | available | restoring |
    /// copying | deleting.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .cluster_configuration = "ClusterConfiguration",
        .data_tiering = "DataTiering",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .source = "Source",
        .status = "Status",
    };
};
