const RetrievalMode = @import("retrieval_mode.zig").RetrievalMode;

/// Specifies the access method and settings to use when retrieving occurrences
/// of sensitive data reported by findings. If your request specifies an
/// Identity and Access Management (IAM) role to assume, Amazon Macie verifies
/// that the role exists and the attached policies are configured correctly. If
/// there's an issue, Macie returns an error. For information about addressing
/// the issue, see [Configuration options for retrieving sensitive data
/// samples](https://docs.aws.amazon.com/macie/latest/user/findings-retrieve-sd-options.html) in the *Amazon Macie User Guide*.
pub const UpdateRetrievalConfiguration = struct {
    /// The access method to use when retrieving sensitive data from affected S3
    /// objects. Valid values are: ASSUME_ROLE, assume an IAM role that is in the
    /// affected Amazon Web Services account and delegates access to Amazon Macie;
    /// and, CALLER_CREDENTIALS, use the credentials of the IAM user who requests
    /// the sensitive data. If you specify ASSUME_ROLE, also specify the name of an
    /// existing IAM role for Macie to assume (roleName).
    ///
    /// If you change this value from ASSUME_ROLE to CALLER_CREDENTIALS for an
    /// existing configuration, Macie permanently deletes the external ID and role
    /// name currently specified for the configuration. These settings can't be
    /// recovered after they're deleted.
    retrieval_mode: RetrievalMode,

    /// The name of the IAM role that is in the affected Amazon Web Services account
    /// and Amazon Macie is allowed to assume when retrieving sensitive data from
    /// affected S3 objects for the account. The trust and permissions policies for
    /// the role must meet all requirements for Macie to assume the role.
    role_name: ?[]const u8,

    pub const json_field_names = .{
        .retrieval_mode = "retrievalMode",
        .role_name = "roleName",
    };
};
