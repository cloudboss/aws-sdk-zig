/// Configures inspection of the response status code.
/// This is part of the `ResponseInspection` configuration for
/// `AWSManagedRulesATPRuleSet` and `AWSManagedRulesACFPRuleSet`.
///
/// Response inspection is available only in web ACLs that protect Amazon
/// CloudFront distributions.
pub const ResponseInspectionStatusCode = struct {
    /// Status codes in the response that indicate a failed login or account
    /// creation attempt. To be counted as a failure, the response status code must
    /// match one of these. Each code must be unique among the success and failure
    /// status codes.
    ///
    /// JSON example: `"FailureCodes": [ 400, 404 ]`
    failure_codes: []const i32,

    /// Status codes in the response that indicate a successful login or account
    /// creation attempt. To be counted as a success, the response status code must
    /// match one of these. Each code must be unique among the success and failure
    /// status codes.
    ///
    /// JSON example: `"SuccessCodes": [ 200, 201 ]`
    success_codes: []const i32,

    pub const json_field_names = .{
        .failure_codes = "FailureCodes",
        .success_codes = "SuccessCodes",
    };
};
