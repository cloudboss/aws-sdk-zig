const CreateDelegationRequest = @import("create_delegation_request.zig").CreateDelegationRequest;

/// An error entity for the `BatchCreateDelegationByAssessment` API. This is
/// used to provide more meaningful errors than a simple string message.
pub const BatchCreateDelegationByAssessmentError = struct {
    /// The API request to batch create delegations in Audit Manager.
    create_delegation_request: ?CreateDelegationRequest,

    /// The error code that the `BatchCreateDelegationByAssessment` API returned.
    error_code: ?[]const u8,

    /// The error message that the `BatchCreateDelegationByAssessment` API returned.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .create_delegation_request = "createDelegationRequest",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
