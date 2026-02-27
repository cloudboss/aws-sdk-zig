const DeliveryStatus = @import("delivery_status.zig").DeliveryStatus;

/// Provides status of the delivery of the snapshot or the
/// configuration history to the specified Amazon S3 bucket. Also
/// provides the status of notifications about the Amazon S3 delivery to
/// the specified Amazon SNS topic.
pub const ConfigExportDeliveryInfo = struct {
    /// The time of the last attempted delivery.
    last_attempt_time: ?i64,

    /// The error code from the last attempted delivery.
    last_error_code: ?[]const u8,

    /// The error message from the last attempted delivery.
    last_error_message: ?[]const u8,

    /// Status of the last attempted delivery.
    last_status: ?DeliveryStatus,

    /// The time of the last successful delivery.
    last_successful_time: ?i64,

    /// The time that the next delivery occurs.
    next_delivery_time: ?i64,

    pub const json_field_names = .{
        .last_attempt_time = "lastAttemptTime",
        .last_error_code = "lastErrorCode",
        .last_error_message = "lastErrorMessage",
        .last_status = "lastStatus",
        .last_successful_time = "lastSuccessfulTime",
        .next_delivery_time = "nextDeliveryTime",
    };
};
