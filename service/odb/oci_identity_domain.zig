const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about an Oracle Cloud Infrastructure (OCI) identity domain
/// configuration.
pub const OciIdentityDomain = struct {
    /// The Amazon Web Services CloudFormation URL for setting up the account
    /// integration with the OCI identity domain.
    account_setup_cloud_formation_url: ?[]const u8 = null,

    /// The unique identifier of the OCI identity domain.
    oci_identity_domain_id: ?[]const u8 = null,

    /// The resource URL for accessing the OCI identity domain.
    oci_identity_domain_resource_url: ?[]const u8 = null,

    /// The URL of the OCI identity domain.
    oci_identity_domain_url: ?[]const u8 = null,

    /// The current status of the OCI identity domain.
    status: ?ResourceStatus = null,

    /// Additional information about the current status of the OCI identity domain,
    /// if applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_setup_cloud_formation_url = "accountSetupCloudFormationUrl",
        .oci_identity_domain_id = "ociIdentityDomainId",
        .oci_identity_domain_resource_url = "ociIdentityDomainResourceUrl",
        .oci_identity_domain_url = "ociIdentityDomainUrl",
        .status = "status",
        .status_reason = "statusReason",
    };
};
