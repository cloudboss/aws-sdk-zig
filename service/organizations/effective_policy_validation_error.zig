/// Contains details about the validation errors that occurred when generating
/// or
/// enforcing an [effective
/// policy](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_effective.html), such as which policies contributed to the error and location of the
/// error.
pub const EffectivePolicyValidationError = struct {
    /// The individual policies
    /// [inherited](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_inheritance_mgmt.html) and [attached](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_policies_attach.html) to
    /// the account which contributed to the validation error.
    contributing_policies: ?[]const []const u8,

    /// The error code for the validation error. For example,
    /// `ELEMENTS_TOO_MANY`.
    error_code: ?[]const u8,

    /// The error message for the validation error.
    error_message: ?[]const u8,

    /// The path within the effective policy where the validation error occurred.
    path_to_error: ?[]const u8,

    pub const json_field_names = .{
        .contributing_policies = "ContributingPolicies",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .path_to_error = "PathToError",
    };
};
