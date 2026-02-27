/// An error entity for the `BatchDeleteDelegationByAssessment` API. This is
/// used to provide more meaningful errors than a simple string message.
pub const BatchDeleteDelegationByAssessmentError = struct {
    /// The identifier for the delegation.
    delegation_id: ?[]const u8,

    /// The error code that the `BatchDeleteDelegationByAssessment` API returned.
    error_code: ?[]const u8,

    /// The error message that the `BatchDeleteDelegationByAssessment` API returned.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .delegation_id = "delegationId",
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
