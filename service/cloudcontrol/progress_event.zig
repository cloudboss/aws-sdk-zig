const HandlerErrorCode = @import("handler_error_code.zig").HandlerErrorCode;
const Operation = @import("operation.zig").Operation;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// Represents the current status of a resource operation request. For more
/// information, see
/// [Managing resource operation
/// requests](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-manage-requests.html) in the
/// *Amazon Web Services Cloud Control API User Guide*.
pub const ProgressEvent = struct {
    /// For requests with a status of `FAILED`, the associated error code.
    ///
    /// For error code definitions, see [Handler error
    /// codes](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-test-contract-errors.html) in the *CloudFormation Command
    /// Line Interface User Guide for Extension Development*.
    error_code: ?HandlerErrorCode = null,

    /// When the resource operation request was initiated.
    event_time: ?i64 = null,

    /// The unique token representing the Hooks operation for the request.
    hooks_request_token: ?[]const u8 = null,

    /// The primary identifier for the resource.
    ///
    /// In some cases, the resource identifier may be available before the resource
    /// operation
    /// has reached a status of `SUCCESS`.
    identifier: ?[]const u8 = null,

    /// The resource operation type.
    operation: ?Operation = null,

    /// The current status of the resource operation request.
    ///
    /// * `PENDING`: The resource operation hasn't yet started.
    ///
    /// * `IN_PROGRESS`: The resource operation is currently in progress.
    ///
    /// * `SUCCESS`: The resource operation has successfully completed.
    ///
    /// * `FAILED`: The resource operation has failed. Refer to the error code and
    /// status message for more information.
    ///
    /// * `CANCEL_IN_PROGRESS`: The resource operation is in the process of being
    /// canceled.
    ///
    /// * `CANCEL_COMPLETE`: The resource operation has been canceled.
    operation_status: ?OperationStatus = null,

    /// The unique token representing this resource operation request.
    ///
    /// Use the `RequestToken` with
    /// [GetResourceRequestStatus](https://docs.aws.amazon.com/cloudcontrolapi/latest/APIReference/API_GetResourceRequestStatus.html) to return the current status of a resource operation
    /// request.
    request_token: ?[]const u8 = null,

    /// A JSON string containing the resource model, consisting of each resource
    /// property and its
    /// current value.
    resource_model: ?[]const u8 = null,

    /// When to next request the status of this resource operation request.
    retry_after: ?i64 = null,

    /// Any message explaining the current status.
    status_message: ?[]const u8 = null,

    /// The name of the resource type used in the operation.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .event_time = "EventTime",
        .hooks_request_token = "HooksRequestToken",
        .identifier = "Identifier",
        .operation = "Operation",
        .operation_status = "OperationStatus",
        .request_token = "RequestToken",
        .resource_model = "ResourceModel",
        .retry_after = "RetryAfter",
        .status_message = "StatusMessage",
        .type_name = "TypeName",
    };
};
