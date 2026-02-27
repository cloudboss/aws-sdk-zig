const RequestInspectionACFP = @import("request_inspection_acfp.zig").RequestInspectionACFP;
const ResponseInspection = @import("response_inspection.zig").ResponseInspection;

/// Details for your use of the account creation fraud prevention managed rule
/// group, `AWSManagedRulesACFPRuleSet`. This configuration is used in
/// `ManagedRuleGroupConfig`.
///
/// For additional information about this and the other intelligent threat
/// mitigation rule groups,
/// see [Intelligent threat mitigation in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-managed-protections)
/// and [Amazon Web Services Managed Rules rule groups
/// list](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-list)
/// in the *WAF Developer Guide*.
pub const AWSManagedRulesACFPRuleSet = struct {
    /// The path of the account creation endpoint for your application. This is the
    /// page on your website that accepts the completed registration form for a new
    /// user. This page must accept `POST` requests.
    ///
    /// For example, for the URL `https://example.com/web/newaccount`, you would
    /// provide
    /// the path `/web/newaccount`. Account creation page paths that
    /// start with the path that you provide are considered a match. For example
    /// `/web/newaccount` matches the account creation paths
    /// `/web/newaccount`, `/web/newaccount/`,
    /// `/web/newaccountPage`, and
    /// `/web/newaccount/thisPage`, but doesn't match the path
    /// `/home/web/newaccount` or
    /// `/website/newaccount`.
    creation_path: []const u8,

    /// Allow the use of regular expressions in the registration page path and the
    /// account creation path.
    enable_regex_in_path: bool = false,

    /// The path of the account registration endpoint for your application. This is
    /// the page on your website that presents the registration form to new users.
    ///
    /// This page must accept `GET` text/html requests.
    ///
    /// For example, for the URL `https://example.com/web/registration`, you would
    /// provide
    /// the path `/web/registration`. Registration page paths that
    /// start with the path that you provide are considered a match. For example
    /// `/web/registration` matches the registration paths
    /// `/web/registration`, `/web/registration/`,
    /// `/web/registrationPage`, and
    /// `/web/registration/thisPage`, but doesn't match the path
    /// `/home/web/registration` or
    /// `/website/registration`.
    registration_page_path: []const u8,

    /// The criteria for inspecting account creation requests, used by the ACFP rule
    /// group to validate and track account creation attempts.
    request_inspection: RequestInspectionACFP,

    /// The criteria for inspecting responses to account creation requests, used by
    /// the ACFP rule group to track account creation success rates.
    ///
    /// Response inspection is available only in web ACLs that protect Amazon
    /// CloudFront distributions.
    ///
    /// The ACFP rule group evaluates the responses that your protected resources
    /// send back to client account creation attempts, keeping count of successful
    /// and failed attempts from each IP address and client session. Using this
    /// information, the rule group labels
    /// and mitigates requests from client sessions and IP addresses that have had
    /// too many successful account creation attempts in a short amount of time.
    response_inspection: ?ResponseInspection,

    pub const json_field_names = .{
        .creation_path = "CreationPath",
        .enable_regex_in_path = "EnableRegexInPath",
        .registration_page_path = "RegistrationPagePath",
        .request_inspection = "RequestInspection",
        .response_inspection = "ResponseInspection",
    };
};
