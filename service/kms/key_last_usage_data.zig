const KeyLastUsageTrackingOperation = @import("key_last_usage_tracking_operation.zig").KeyLastUsageTrackingOperation;

/// Contains usage information about the last time the KMS key was used for a
/// successful cryptographic
/// operation.
pub const KeyLastUsageData = struct {
    /// The CloudTrail `eventId` associated with the last successful cryptographic
    /// operation.
    /// Absent if the key has not been used since KMS began tracking.
    cloud_trail_event_id: ?[]const u8 = null,

    /// The KMS request ID associated with the last successful cryptographic
    /// operation. Absent if the key
    /// has not been used since KMS began tracking.
    kms_request_id: ?[]const u8 = null,

    /// The last successful cryptographic operation the KMS key was used for. Absent
    /// if the key has not been
    /// used since KMS began tracking.
    operation: ?KeyLastUsageTrackingOperation = null,

    /// The date and time when the KMS key was most recently used for a successful
    /// cryptographic
    /// operation. Absent if the key has not been used since KMS began tracking.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .cloud_trail_event_id = "CloudTrailEventId",
        .kms_request_id = "KmsRequestId",
        .operation = "Operation",
        .timestamp = "Timestamp",
    };
};
