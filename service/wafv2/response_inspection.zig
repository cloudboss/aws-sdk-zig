const ResponseInspectionBodyContains = @import("response_inspection_body_contains.zig").ResponseInspectionBodyContains;
const ResponseInspectionHeader = @import("response_inspection_header.zig").ResponseInspectionHeader;
const ResponseInspectionJson = @import("response_inspection_json.zig").ResponseInspectionJson;
const ResponseInspectionStatusCode = @import("response_inspection_status_code.zig").ResponseInspectionStatusCode;

/// The criteria for inspecting responses to login requests and account creation
/// requests, used by the ATP and ACFP rule groups to track login and account
/// creation success and failure rates.
///
/// Response inspection is available only in web ACLs that protect Amazon
/// CloudFront distributions.
///
/// The rule groups evaluates the responses that your protected resources send
/// back to client login and account creation attempts, keeping count of
/// successful and failed attempts from each IP address and client session.
/// Using this information, the rule group labels
/// and mitigates requests from client sessions and IP addresses with too much
/// suspicious activity in a short amount of time.
///
/// This is part of the `AWSManagedRulesATPRuleSet` and
/// `AWSManagedRulesACFPRuleSet` configurations in `ManagedRuleGroupConfig`.
///
/// Enable response inspection by configuring exactly one component of the
/// response to inspect, for example, `Header` or `StatusCode`. You can't
/// configure more than one component for inspection. If you don't configure any
/// of the response inspection options, response inspection is disabled.
pub const ResponseInspection = struct {
    /// Configures inspection of the response body for success and failure
    /// indicators. WAF can inspect the first 65,536 bytes (64 KB) of the response
    /// body.
    body_contains: ?ResponseInspectionBodyContains,

    /// Configures inspection of the response header for success and failure
    /// indicators.
    header: ?ResponseInspectionHeader,

    /// Configures inspection of the response JSON for success and failure
    /// indicators. WAF can inspect the first 65,536 bytes (64 KB) of the response
    /// JSON.
    json: ?ResponseInspectionJson,

    /// Configures inspection of the response status code for success and failure
    /// indicators.
    status_code: ?ResponseInspectionStatusCode,

    pub const json_field_names = .{
        .body_contains = "BodyContains",
        .header = "Header",
        .json = "Json",
        .status_code = "StatusCode",
    };
};
