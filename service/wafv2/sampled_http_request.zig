const CaptchaResponse = @import("captcha_response.zig").CaptchaResponse;
const ChallengeResponse = @import("challenge_response.zig").ChallengeResponse;
const Label = @import("label.zig").Label;
const HTTPRequest = @import("http_request.zig").HTTPRequest;
const HTTPHeader = @import("http_header.zig").HTTPHeader;

/// Represents a single sampled web request. The response from
/// GetSampledRequests includes a `SampledHTTPRequests` complex type
/// that appears as `SampledRequests` in the response syntax.
/// `SampledHTTPRequests` contains an array of `SampledHTTPRequest`
/// objects.
pub const SampledHTTPRequest = struct {
    /// The action that WAF applied to the request.
    action: ?[]const u8,

    /// The `CAPTCHA` response for the request.
    captcha_response: ?CaptchaResponse,

    /// The `Challenge` response for the request.
    challenge_response: ?ChallengeResponse,

    /// Labels applied to the web request by matching rules. WAF applies fully
    /// qualified
    /// labels to matching web requests. A fully qualified label is the
    /// concatenation of a label
    /// namespace and a rule label. The rule's rule group or web ACL defines the
    /// label namespace.
    ///
    /// For example,
    /// `awswaf:111122223333:myRuleGroup:testRules:testNS1:testNS2:labelNameA` or
    /// `awswaf:managed:aws:managed-rule-set:header:encoding:utf8`.
    labels: ?[]const Label,

    /// Used only for rule group rules that have a rule action override in place in
    /// the web ACL. This is the action that the rule group rule is configured for,
    /// and not the action that was applied to the request. The action that WAF
    /// applied is the `Action` value.
    overridden_action: ?[]const u8,

    /// A complex type that contains detailed information about the request.
    request: HTTPRequest,

    /// Custom request headers inserted by WAF into the request, according to the
    /// custom
    /// request configuration for the matching rule action.
    request_headers_inserted: ?[]const HTTPHeader,

    /// The response code that was sent for the request.
    response_code_sent: ?i32,

    /// The name of the `Rule` that the request matched. For managed rule groups,
    /// the
    /// format for this name is `##`. For your own rule groups, the format for this
    /// name is `#`. If the rule is not in a rule group, this field
    /// is absent.
    rule_name_within_rule_group: ?[]const u8,

    /// The time at which WAF received the request from your Amazon Web Services
    /// resource, in Unix time
    /// format (in seconds).
    timestamp: ?i64,

    /// A value that indicates how one result in the response relates proportionally
    /// to other
    /// results in the response. For example, a result that has a weight of `2`
    /// represents roughly twice as many web requests as a result that has a weight
    /// of
    /// `1`.
    weight: i64 = 0,

    pub const json_field_names = .{
        .action = "Action",
        .captcha_response = "CaptchaResponse",
        .challenge_response = "ChallengeResponse",
        .labels = "Labels",
        .overridden_action = "OverriddenAction",
        .request = "Request",
        .request_headers_inserted = "RequestHeadersInserted",
        .response_code_sent = "ResponseCodeSent",
        .rule_name_within_rule_group = "RuleNameWithinRuleGroup",
        .timestamp = "Timestamp",
        .weight = "Weight",
    };
};
