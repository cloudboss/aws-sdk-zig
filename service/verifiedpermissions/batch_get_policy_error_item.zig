const BatchGetPolicyErrorCode = @import("batch_get_policy_error_code.zig").BatchGetPolicyErrorCode;

/// Contains the information about an error resulting from a `BatchGetPolicy`
/// API call.
pub const BatchGetPolicyErrorItem = struct {
    /// The error code that was returned.
    code: BatchGetPolicyErrorCode,

    /// A detailed error message.
    message: []const u8,

    /// The identifier of the policy associated with the failed request.
    policy_id: []const u8,

    /// The identifier of the policy store associated with the failed request.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
    };
};
