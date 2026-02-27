const FailureReasonCode = @import("failure_reason_code.zig").FailureReasonCode;

/// Request for which contact failed to be generated.
pub const FailedRequest = struct {
    /// Reason code for the failure.
    failure_reason_code: ?FailureReasonCode,

    /// Why the request to create a contact failed.
    failure_reason_message: ?[]const u8,

    /// Request identifier provided in the API call in the ContactDataRequest to
    /// create a contact.
    request_identifier: ?[]const u8,

    pub const json_field_names = .{
        .failure_reason_code = "FailureReasonCode",
        .failure_reason_message = "FailureReasonMessage",
        .request_identifier = "RequestIdentifier",
    };
};
