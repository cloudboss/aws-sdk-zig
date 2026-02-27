const FindingActionType = @import("finding_action_type.zig").FindingActionType;
const ApiCallDetails = @import("api_call_details.zig").ApiCallDetails;

/// Provides information about an action that occurred for a resource and
/// produced a policy finding.
pub const FindingAction = struct {
    /// The type of action that occurred for the affected resource. This value is
    /// typically AWS_API_CALL, which indicates that an entity invoked an API
    /// operation for the resource.
    action_type: ?FindingActionType,

    /// The invocation details of the API operation that an entity invoked for the
    /// affected resource, if the value for the actionType property is AWS_API_CALL.
    api_call_details: ?ApiCallDetails,

    pub const json_field_names = .{
        .action_type = "actionType",
        .api_call_details = "apiCallDetails",
    };
};
