/// Configures inspection of the response header.
/// This is part of the `ResponseInspection` configuration for
/// `AWSManagedRulesATPRuleSet` and `AWSManagedRulesACFPRuleSet`.
///
/// Response inspection is available only in web ACLs that protect Amazon
/// CloudFront distributions.
pub const ResponseInspectionHeader = struct {
    /// Values in the response header with the specified name that indicate a failed
    /// login or account creation attempt. To be counted as a failure, the value
    /// must be an exact match, including case. Each value must be unique among the
    /// success and failure values.
    ///
    /// JSON examples: `"FailureValues": [ "LoginFailed", "Failed login" ]` and
    /// `"FailureValues": [ "AccountCreationFailed" ]`
    failure_values: []const []const u8,

    /// The name of the header to match against. The name must be an exact match,
    /// including case.
    ///
    /// JSON example: `"Name": [ "RequestResult" ]`
    name: []const u8,

    /// Values in the response header with the specified name that indicate a
    /// successful login or account creation attempt. To be counted as a success,
    /// the value must be an exact match, including case. Each value must be unique
    /// among the success and failure values.
    ///
    /// JSON examples: `"SuccessValues": [ "LoginPassed", "Successful login" ]` and
    /// `"SuccessValues": [ "AccountCreated", "Successful account creation" ]`
    success_values: []const []const u8,

    pub const json_field_names = .{
        .failure_values = "FailureValues",
        .name = "Name",
        .success_values = "SuccessValues",
    };
};
