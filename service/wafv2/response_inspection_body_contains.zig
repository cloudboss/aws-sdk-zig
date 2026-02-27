/// Configures inspection of the response body. WAF can inspect the first 65,536
/// bytes (64 KB) of the response body.
/// This is part of the `ResponseInspection` configuration for
/// `AWSManagedRulesATPRuleSet` and `AWSManagedRulesACFPRuleSet`.
///
/// Response inspection is available only in web ACLs that protect Amazon
/// CloudFront distributions.
pub const ResponseInspectionBodyContains = struct {
    /// Strings in the body of the response that indicate a failed login or account
    /// creation attempt. To be counted as a failure, the string can be anywhere in
    /// the body and must be an exact match, including case. Each string must be
    /// unique among the success and failure strings.
    ///
    /// JSON example: `"FailureStrings": [ "Request failed" ]`
    failure_strings: []const []const u8,

    /// Strings in the body of the response that indicate a successful login or
    /// account creation attempt. To be counted as a success, the string can be
    /// anywhere in the body and must be an exact match, including case. Each string
    /// must be unique among the success and failure strings.
    ///
    /// JSON examples: `"SuccessStrings": [ "Login successful" ]` and
    /// `"SuccessStrings": [ "Account creation successful", "Welcome to our site!"
    /// ]`
    success_strings: []const []const u8,

    pub const json_field_names = .{
        .failure_strings = "FailureStrings",
        .success_strings = "SuccessStrings",
    };
};
