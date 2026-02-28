const ResponseHeadersPolicy = @import("response_headers_policy.zig").ResponseHeadersPolicy;
const ResponseHeadersPolicyType = @import("response_headers_policy_type.zig").ResponseHeadersPolicyType;

/// Contains a response headers policy.
pub const ResponseHeadersPolicySummary = struct {
    /// The response headers policy.
    response_headers_policy: ResponseHeadersPolicy,

    /// The type of response headers policy, either `managed` (created by Amazon Web
    /// Services) or `custom` (created in this Amazon Web Services account).
    type: ResponseHeadersPolicyType,
};
