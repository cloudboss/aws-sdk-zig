const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// The status of the replication process for an image.
pub const ImageReplicationStatus = struct {
    /// The failure code for a replication that has failed.
    failure_code: ?[]const u8 = null,

    /// The destination Region for the image replication.
    region: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry to which the
    /// image belongs.
    registry_id: ?[]const u8 = null,

    /// The image replication status.
    status: ?ReplicationStatus = null,

    pub const json_field_names = .{
        .failure_code = "failureCode",
        .region = "region",
        .registry_id = "registryId",
        .status = "status",
    };
};
