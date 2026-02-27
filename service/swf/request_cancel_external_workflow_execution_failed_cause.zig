pub const RequestCancelExternalWorkflowExecutionFailedCause = enum {
    unknown_external_workflow_execution,
    request_cancel_external_workflow_execution_rate_exceeded,
    operation_not_permitted,

    pub const json_field_names = .{
        .unknown_external_workflow_execution = "UNKNOWN_EXTERNAL_WORKFLOW_EXECUTION",
        .request_cancel_external_workflow_execution_rate_exceeded = "REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_RATE_EXCEEDED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };
};
