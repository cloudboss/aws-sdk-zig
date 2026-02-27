const AccountStatus = @import("account_status.zig").AccountStatus;

/// The status of an Amazon Web Services Organization and the accounts within
/// that organization.
pub const OrganizationStatus = struct {
    /// The current service-linked role (SLR) deployment status for an Amazon Web
    /// Services Organization's accounts. This will be either `SUCCEEDED` or
    /// `IN_PROGRESS`.
    account_status_list: ?[]const AccountStatus,

    /// The status of the organization's AWS service access. This will be `ENABLED`
    /// or `DISABLED`.
    organization_aws_service_access_status: ?[]const u8,

    /// The ID of an Amazon Web Services Organization.
    organization_id: ?[]const u8,

    /// The status of the SLR deployment for the account. This will be either
    /// `SUCCEEDED` or `IN_PROGRESS`.
    slr_deployment_status: ?[]const u8,

    pub const json_field_names = .{
        .account_status_list = "AccountStatusList",
        .organization_aws_service_access_status = "OrganizationAwsServiceAccessStatus",
        .organization_id = "OrganizationId",
        .slr_deployment_status = "SLRDeploymentStatus",
    };
};
