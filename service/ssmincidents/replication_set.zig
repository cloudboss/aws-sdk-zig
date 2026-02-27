const aws = @import("aws");

const RegionInfo = @import("region_info.zig").RegionInfo;
const ReplicationSetStatus = @import("replication_set_status.zig").ReplicationSetStatus;

/// The set of Amazon Web Services Region that your Incident Manager data will
/// be replicated to and
/// the KMS key used to encrypt the data.
pub const ReplicationSet = struct {
    /// The Amazon Resource Name (ARN) of the replication set.
    arn: ?[]const u8,

    /// Details about who created the replication set.
    created_by: []const u8,

    /// When the replication set was created.
    created_time: i64,

    /// Determines if the replication set deletion protection is enabled or not. If
    /// deletion
    /// protection is enabled, you can't delete the last Amazon Web Services Region
    /// in the replication
    /// set.
    deletion_protected: bool,

    /// Who last modified the replication set.
    last_modified_by: []const u8,

    /// When the replication set was last updated.
    last_modified_time: i64,

    /// The map between each Amazon Web Services Region in your replication set and
    /// the KMS key that's used to encrypt the data in that Region.
    region_map: []const aws.map.MapEntry(RegionInfo),

    /// The status of the replication set. If the replication set is still pending,
    /// you can't use
    /// Incident Manager functionality.
    status: ReplicationSetStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .created_by = "createdBy",
        .created_time = "createdTime",
        .deletion_protected = "deletionProtected",
        .last_modified_by = "lastModifiedBy",
        .last_modified_time = "lastModifiedTime",
        .region_map = "regionMap",
        .status = "status",
    };
};
