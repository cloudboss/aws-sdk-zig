const RegionStatus = @import("region_status.zig").RegionStatus;

/// Information about a Amazon Web Services Region in your replication set.
pub const RegionInfo = struct {
    /// The ID of the KMS key used to encrypt the data in this Amazon Web Services
    /// Region.
    sse_kms_key_id: ?[]const u8,

    /// The status of the Amazon Web Services Region in the replication set.
    status: RegionStatus,

    /// Information displayed about the status of the Amazon Web Services Region.
    status_message: ?[]const u8,

    /// The timestamp for when Incident Manager updated the status of the Amazon Web
    /// Services Region.
    status_update_date_time: i64,

    pub const json_field_names = .{
        .sse_kms_key_id = "sseKmsKeyId",
        .status = "status",
        .status_message = "statusMessage",
        .status_update_date_time = "statusUpdateDateTime",
    };
};
