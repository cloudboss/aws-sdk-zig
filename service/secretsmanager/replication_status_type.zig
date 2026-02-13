const StatusType = @import("status_type.zig").StatusType;

/// A replication object consisting of a `RegionReplicationStatus` object and
/// includes a Region, KMSKeyId, status, and status message.
pub const ReplicationStatusType = struct {
    /// Can be an `ARN`, `Key ID`, or `Alias`.
    kms_key_id: ?[]const u8,

    /// The date that the secret was last accessed in the Region. This field is
    /// omitted if the
    /// secret has never been retrieved in the Region.
    last_accessed_date: ?i64,

    /// The Region where replication occurs.
    region: ?[]const u8,

    /// The status can be `InProgress`, `Failed`, or
    /// `InSync`.
    status: ?StatusType,

    /// Status message such as "*Secret with this name already exists in this
    /// region*".
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .last_accessed_date = "LastAccessedDate",
        .region = "Region",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
