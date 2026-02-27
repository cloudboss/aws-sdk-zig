const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Information about a principal.
pub const Principal = struct {
    /// The ARN of the principal (user, role, or group). This field allows for an
    /// ARN with no `accountID`, with or without wildcard characters if the
    /// `PrincipalType` is an `IAM_PATTERN`.
    ///
    /// For more information, review
    /// [associate-principal-with-portfolio](https://docs.aws.amazon.com/cli/latest/reference/servicecatalog/associate-principal-with-portfolio.html#options)
    /// in the Amazon Web Services CLI Command Reference.
    principal_arn: ?[]const u8,

    /// The principal type. The supported value is `IAM` if you use a fully defined
    /// ARN, or
    /// `IAM_PATTERN` if you use an ARN with no `accountID`, with or without
    /// wildcard characters.
    principal_type: ?PrincipalType,

    pub const json_field_names = .{
        .principal_arn = "PrincipalARN",
        .principal_type = "PrincipalType",
    };
};
