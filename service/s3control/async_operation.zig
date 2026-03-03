const AsyncOperationName = @import("async_operation_name.zig").AsyncOperationName;
const AsyncRequestParameters = @import("async_request_parameters.zig").AsyncRequestParameters;
const AsyncResponseDetails = @import("async_response_details.zig").AsyncResponseDetails;

/// A container for the information about an asynchronous operation.
pub const AsyncOperation = struct {
    /// The time that the request was sent to the service.
    creation_time: ?i64 = null,

    /// The specific operation for the asynchronous request.
    operation: ?AsyncOperationName = null,

    /// The parameters associated with the request.
    request_parameters: ?AsyncRequestParameters = null,

    /// The current status of the request.
    request_status: ?[]const u8 = null,

    /// The request token associated with the request.
    request_token_arn: ?[]const u8 = null,

    /// The details of the response.
    response_details: ?AsyncResponseDetails = null,
};
