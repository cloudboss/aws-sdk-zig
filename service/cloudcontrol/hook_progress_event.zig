/// Represents the current status of applicable Hooks for a resource operation
/// request. It contains list of
/// Hook invocation information for the resource specified in the request since
/// the same target can invoke multiple Hooks.
/// For more information, see [Managing resource operation requests with Amazon
/// Web Services Cloud Control API
/// ](https://docs.aws.amazon.com/cloudcontrolapi/latest/userguide/resource-operations-manage-requests.html).
pub const HookProgressEvent = struct {
    /// The failure mode of the invocation. The following are the potential
    /// statuses:
    ///
    /// * `FAIL`: This will fail the Hook invocation and the request associated with
    ///   it.
    ///
    /// * `WARN`: This will fail the Hook invocation, but not the request associated
    ///   with it.
    failure_mode: ?[]const u8 = null,

    /// The time that the Hook invocation request initiated.
    hook_event_time: ?i64 = null,

    /// The status of the Hook invocation. The following are potential statuses:
    ///
    /// * `HOOK_PENDING`: The Hook was added to the invocation plan, but not yet
    ///   invoked.
    ///
    /// * `HOOK_IN_PROGRESS`: The Hook was invoked, but hasn't completed.
    ///
    /// * `HOOK_COMPLETE_SUCCEEDED`: The Hook invocation is complete with a
    ///   successful result.
    ///
    /// * `HOOK_COMPLETE_FAILED`: The Hook invocation is complete with a failed
    ///   result.
    ///
    /// * `HOOK_FAILED`: The Hook invocation didn't complete successfully.
    hook_status: ?[]const u8 = null,

    /// The message explaining the current Hook status.
    hook_status_message: ?[]const u8 = null,

    /// The ARN of the Hook being invoked.
    hook_type_arn: ?[]const u8 = null,

    /// The type name of the Hook being invoked.
    hook_type_name: ?[]const u8 = null,

    /// The type version of the Hook being invoked.
    hook_type_version_id: ?[]const u8 = null,

    /// States whether the Hook is invoked before or after resource provisioning.
    invocation_point: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_mode = "FailureMode",
        .hook_event_time = "HookEventTime",
        .hook_status = "HookStatus",
        .hook_status_message = "HookStatusMessage",
        .hook_type_arn = "HookTypeArn",
        .hook_type_name = "HookTypeName",
        .hook_type_version_id = "HookTypeVersionId",
        .invocation_point = "InvocationPoint",
    };
};
