const VerificationStatus = @import("verification_status.zig").VerificationStatus;

/// A structure containing information about an Lake Formation resource.
pub const ResourceInfo = struct {
    /// The Amazon Web Services account that owns the Glue tables associated with
    /// specific Amazon S3 locations.
    expected_resource_owner_account: ?[]const u8 = null,

    /// Indicates whether the data access of tables pointing to the location can be
    /// managed by both Lake Formation permissions as well as Amazon S3 bucket
    /// policies.
    hybrid_access_enabled: ?bool = null,

    /// The date and time the resource was last modified.
    last_modified: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// The IAM role that registered a resource.
    role_arn: ?[]const u8 = null,

    /// Indicates whether the registered role has sufficient permissions to access
    /// registered Amazon S3 location. Verification Status can be one of the
    /// following:
    ///
    /// * VERIFIED - Registered role has sufficient permissions to access registered
    ///   Amazon S3 location.
    ///
    /// * NOT_VERIFIED - Registered role does not have sufficient permissions to
    ///   access registered Amazon S3 location.
    ///
    /// * VERIFICATION_FAILED - Unable to verify if the registered role can access
    ///   the registered Amazon S3 location.
    verification_status: ?VerificationStatus = null,

    /// Whether or not the resource is a federated resource.
    with_federation: ?bool = null,

    /// Grants the calling principal the permissions to perform all supported Lake
    /// Formation operations on the registered data location.
    with_privileged_access: ?bool = null,

    pub const json_field_names = .{
        .expected_resource_owner_account = "ExpectedResourceOwnerAccount",
        .hybrid_access_enabled = "HybridAccessEnabled",
        .last_modified = "LastModified",
        .resource_arn = "ResourceArn",
        .role_arn = "RoleArn",
        .verification_status = "VerificationStatus",
        .with_federation = "WithFederation",
        .with_privileged_access = "WithPrivilegedAccess",
    };
};
