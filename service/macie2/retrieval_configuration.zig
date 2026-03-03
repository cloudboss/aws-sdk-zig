const RetrievalMode = @import("retrieval_mode.zig").RetrievalMode;

/// Provides information about the access method and settings that are used to
/// retrieve occurrences of sensitive data reported by findings.
pub const RetrievalConfiguration = struct {
    /// The external ID to specify in the trust policy for the IAM role to assume
    /// when retrieving sensitive data from affected S3 objects (roleName). This
    /// value is null if the value for retrievalMode is CALLER_CREDENTIALS.
    ///
    /// This ID is a unique alphanumeric string that Amazon Macie generates
    /// automatically after you configure it to assume an IAM role. For a Macie
    /// administrator to retrieve sensitive data from an affected S3 object for a
    /// member account, the trust policy for the role in the member account must
    /// include an sts:ExternalId condition that requires this ID.
    external_id: ?[]const u8 = null,

    /// The access method that's used to retrieve sensitive data from affected S3
    /// objects. Valid values are: ASSUME_ROLE, assume an IAM role that is in the
    /// affected Amazon Web Services account and delegates access to Amazon Macie
    /// (roleName); and, CALLER_CREDENTIALS, use the credentials of the IAM user who
    /// requests the sensitive data.
    retrieval_mode: RetrievalMode,

    /// The name of the IAM role that is in the affected Amazon Web Services account
    /// and Amazon Macie is allowed to assume when retrieving sensitive data from
    /// affected S3 objects for the account. This value is null if the value for
    /// retrievalMode is CALLER_CREDENTIALS.
    role_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .external_id = "externalId",
        .retrieval_mode = "retrievalMode",
        .role_name = "roleName",
    };
};
