const OriginRequestPolicy = @import("origin_request_policy.zig").OriginRequestPolicy;
const OriginRequestPolicyType = @import("origin_request_policy_type.zig").OriginRequestPolicyType;

/// Contains an origin request policy.
pub const OriginRequestPolicySummary = struct {
    /// The origin request policy.
    origin_request_policy: OriginRequestPolicy,

    /// The type of origin request policy, either `managed` (created by Amazon Web
    /// Services) or `custom` (created in this Amazon Web Services account).
    type: OriginRequestPolicyType,
};
