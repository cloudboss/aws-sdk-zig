const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains error messages associated with the deletion request.
pub const BatchDeleteDetectorErrorEntry = struct {
    /// The error code.
    error_code: ?ErrorCode,

    /// A message that describes the error.
    error_message: ?[]const u8,

    /// The ID of the message that caused the error. (See the value of the
    /// `"messageId"` in the
    /// [detectors](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchDeleteDetector.html#iotevents-iotevents-data_BatchDeleteDetector-request-detectors) object of the `DeleteDetectorRequest`.)
    message_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .message_id = "messageId",
    };
};
