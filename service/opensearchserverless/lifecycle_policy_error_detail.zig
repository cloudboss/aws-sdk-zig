const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// Error information for an OpenSearch Serverless request.
pub const LifecyclePolicyErrorDetail = struct {
    /// The error code for the request. For example, `NOT_FOUND`.
    error_code: ?[]const u8 = null,

    /// A description of the error. For example, `The specified Lifecycle Policy is
    /// not found`.
    error_message: ?[]const u8 = null,

    /// The name of the lifecycle policy.
    name: ?[]const u8 = null,

    /// The type of lifecycle policy.
    @"type": ?LifecyclePolicyType = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .name = "name",
        .@"type" = "type",
    };
};
