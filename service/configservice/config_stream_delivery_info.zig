const DeliveryStatus = @import("delivery_status.zig").DeliveryStatus;

/// A list that contains the status of the delivery of the
/// configuration stream notification to the Amazon SNS topic.
pub const ConfigStreamDeliveryInfo = struct {
    /// The error code from the last attempted delivery.
    last_error_code: ?[]const u8 = null,

    /// The error message from the last attempted delivery.
    last_error_message: ?[]const u8 = null,

    /// Status of the last attempted delivery.
    ///
    /// **Note** Providing an SNS topic on a
    /// [DeliveryChannel](https://docs.aws.amazon.com/config/latest/APIReference/API_DeliveryChannel.html) for Config is optional. If the SNS
    /// delivery is turned off, the last status will be **Not_Applicable**.
    last_status: ?DeliveryStatus = null,

    /// The time from the last status change.
    last_status_change_time: ?i64 = null,

    pub const json_field_names = .{
        .last_error_code = "lastErrorCode",
        .last_error_message = "lastErrorMessage",
        .last_status = "lastStatus",
        .last_status_change_time = "lastStatusChangeTime",
    };
};
