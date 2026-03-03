/// Describes the current status of an account within an Amazon Web Services
/// Organization, including service-linked roles (SLRs).
pub const AccountStatus = struct {
    /// The ID of an account within the Amazon Web Services Organization.
    account_id: ?[]const u8 = null,

    /// The status of SLR deployment for the account.
    slr_deployment_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .slr_deployment_status = "SLRDeploymentStatus",
    };
};
