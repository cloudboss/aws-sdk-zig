const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains error messages associated with one of the following requests:
///
/// *
///   [BatchAcknowledgeAlarm](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchAcknowledgeAlarm.html)
///
/// *
///   [BatchDisableAlarm](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchDisableAlarm.html)
///
/// *
///   [BatchEnableAlarm](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchEnableAlarm.html)
///
/// *
///   [BatchResetAlarm](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchResetAlarm.html)
///
/// *
///   [BatchSnoozeAlarm](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchSnoozeAlarm.html)
pub const BatchAlarmActionErrorEntry = struct {
    /// The error code.
    error_code: ?ErrorCode,

    /// A message that describes the error.
    error_message: ?[]const u8,

    /// The request ID. Each ID must be unique within each batch.
    request_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .request_id = "requestId",
    };
};
