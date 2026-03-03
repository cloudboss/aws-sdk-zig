const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Specifies whether Amazon S3 access grants are enabled for query
/// results.
pub const QueryResultsS3AccessGrantsConfiguration = struct {
    /// The authentication type used for Amazon S3 access grants. Currently, only
    /// `DIRECTORY_IDENTITY` is supported.
    authentication_type: AuthenticationType,

    /// When enabled, appends the user ID as an Amazon S3 path prefix to the query
    /// result output location.
    create_user_level_prefix: ?bool = null,

    /// Specifies whether Amazon S3 access grants are enabled for query
    /// results.
    enable_s3_access_grants: bool,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .create_user_level_prefix = "CreateUserLevelPrefix",
        .enable_s3_access_grants = "EnableS3AccessGrants",
    };
};
