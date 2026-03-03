const AwsIamAccessKeySessionContext = @import("aws_iam_access_key_session_context.zig").AwsIamAccessKeySessionContext;
const AwsIamAccessKeyStatus = @import("aws_iam_access_key_status.zig").AwsIamAccessKeyStatus;

/// IAM access key details related to a finding.
pub const AwsIamAccessKeyDetails = struct {
    /// The identifier of the access key.
    access_key_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the account for the key.
    account_id: ?[]const u8 = null,

    /// Indicates when the IAM access key was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?[]const u8 = null,

    /// The ID of the principal associated with an access key.
    principal_id: ?[]const u8 = null,

    /// The name of the principal.
    principal_name: ?[]const u8 = null,

    /// The type of principal associated with an access key.
    principal_type: ?[]const u8 = null,

    /// Information about the session that the key was used for.
    session_context: ?AwsIamAccessKeySessionContext = null,

    /// The status of the IAM access key related to a finding.
    status: ?AwsIamAccessKeyStatus = null,

    /// The user associated with the IAM access key related to a finding.
    ///
    /// The `UserName` parameter has been replaced with the
    /// `PrincipalName` parameter because access keys can also be assigned to
    /// principals that are not IAM users.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .account_id = "AccountId",
        .created_at = "CreatedAt",
        .principal_id = "PrincipalId",
        .principal_name = "PrincipalName",
        .principal_type = "PrincipalType",
        .session_context = "SessionContext",
        .status = "Status",
        .user_name = "UserName",
    };
};
