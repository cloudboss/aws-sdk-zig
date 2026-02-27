const RequestInspection = @import("request_inspection.zig").RequestInspection;
const ResponseInspection = @import("response_inspection.zig").ResponseInspection;

/// Details for your use of the account takeover prevention managed rule group,
/// `AWSManagedRulesATPRuleSet`. This configuration is used in
/// `ManagedRuleGroupConfig`.
///
/// For additional information about this and the other intelligent threat
/// mitigation rule groups,
/// see [Intelligent threat mitigation in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-managed-protections)
/// and [Amazon Web Services Managed Rules rule groups
/// list](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-list)
/// in the *WAF Developer Guide*.
pub const AWSManagedRulesATPRuleSet = struct {
    /// Allow the use of regular expressions in the login page path.
    enable_regex_in_path: bool = false,

    /// The path of the login endpoint for your application. For example, for the
    /// URL
    /// `https://example.com/web/login`, you would provide the path
    /// `/web/login`. Login paths that start with the path that you provide are
    /// considered a match. For example `/web/login` matches the login paths
    /// `/web/login`, `/web/login/`, `/web/loginPage`, and `/web/login/thisPage`,
    /// but doesn't match the login path `/home/web/login` or `/website/login`.
    ///
    /// The rule group inspects only HTTP `POST` requests to your specified login
    /// endpoint.
    login_path: []const u8,

    /// The criteria for inspecting login requests, used by the ATP rule group to
    /// validate credentials usage.
    request_inspection: ?RequestInspection,

    /// The criteria for inspecting responses to login requests, used by the ATP
    /// rule group to track login failure rates.
    ///
    /// Response inspection is available only in web ACLs that protect Amazon
    /// CloudFront distributions.
    ///
    /// The ATP rule group evaluates the responses that your protected resources
    /// send back to client login attempts, keeping count of successful and failed
    /// attempts for each IP address and client session. Using this information, the
    /// rule group labels
    /// and mitigates requests from client sessions and IP addresses that have had
    /// too many failed login attempts in a short amount of time.
    response_inspection: ?ResponseInspection,

    pub const json_field_names = .{
        .enable_regex_in_path = "EnableRegexInPath",
        .login_path = "LoginPath",
        .request_inspection = "RequestInspection",
        .response_inspection = "ResponseInspection",
    };
};
