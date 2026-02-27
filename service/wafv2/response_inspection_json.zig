/// Configures inspection of the response JSON. WAF can inspect the first 65,536
/// bytes (64 KB) of the response JSON.
/// This is part of the `ResponseInspection` configuration for
/// `AWSManagedRulesATPRuleSet` and `AWSManagedRulesACFPRuleSet`.
///
/// Response inspection is available only in web ACLs that protect Amazon
/// CloudFront distributions.
pub const ResponseInspectionJson = struct {
    /// Values for the specified identifier in the response JSON that indicate a
    /// failed login or account creation attempt. To be counted as a failure, the
    /// value must be an exact match, including case. Each value must be unique
    /// among the success and failure values.
    ///
    /// JSON example: `"FailureValues": [ "False", "Failed" ]`
    failure_values: []const []const u8,

    /// The identifier for the value to match against in the JSON. The identifier
    /// must be an exact match, including case.
    ///
    /// JSON examples: `"Identifier": [ "/login/success" ]` and `"Identifier": [
    /// "/sign-up/success" ]`
    identifier: []const u8,

    /// Values for the specified identifier in the response JSON that indicate a
    /// successful login or account creation attempt. To be counted as a success,
    /// the value must be an exact match, including case. Each value must be unique
    /// among the success and failure values.
    ///
    /// JSON example: `"SuccessValues": [ "True", "Succeeded" ]`
    success_values: []const []const u8,

    pub const json_field_names = .{
        .failure_values = "FailureValues",
        .identifier = "Identifier",
        .success_values = "SuccessValues",
    };
};
