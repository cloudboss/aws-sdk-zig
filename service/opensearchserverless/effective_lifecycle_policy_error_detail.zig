const LifecyclePolicyType = @import("lifecycle_policy_type.zig").LifecyclePolicyType;

/// Error information for an OpenSearch Serverless request.
pub const EffectiveLifecyclePolicyErrorDetail = struct {
    /// The error code for the request.
    error_code: ?[]const u8 = null,

    /// A description of the error. For example, `The specified Index resource is
    /// not found`.
    error_message: ?[]const u8 = null,

    /// The name of OpenSearch Serverless index resource.
    resource: ?[]const u8 = null,

    /// The type of lifecycle policy.
    @"type": ?LifecyclePolicyType = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .resource = "resource",
        .@"type" = "type",
    };
};
