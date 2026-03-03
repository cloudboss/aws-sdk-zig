const OrganizationStatus = @import("organization_status.zig").OrganizationStatus;

/// Contains high level information about the Firewall Manager administrator
/// account.
pub const AdminAccountSummary = struct {
    /// The Amazon Web Services account ID of the Firewall Manager administrator's
    /// account.
    admin_account: ?[]const u8 = null,

    /// A boolean value that indicates if the administrator is the default
    /// administrator. If true, then this is the default administrator account. The
    /// default administrator can manage third-party firewalls and has full
    /// administrative scope. There is only one default administrator account per
    /// organization. For information about Firewall Manager default administrator
    /// accounts, see [Managing Firewall Manager
    /// administrators](https://docs.aws.amazon.com/waf/latest/developerguide/fms-administrators.html) in the *Firewall Manager Developer Guide*.
    default_admin: bool = false,

    /// The current status of the request to onboard a member account as an Firewall
    /// Manager administrator.
    ///
    /// * `ONBOARDING` - The account is onboarding to Firewall Manager as an
    ///   administrator.
    ///
    /// * `ONBOARDING_COMPLETE` - Firewall Manager The account is onboarded to
    ///   Firewall Manager as an administrator, and can perform actions on the
    ///   resources defined in their AdminScope.
    ///
    /// * `OFFBOARDING` - The account is being removed as an Firewall Manager
    ///   administrator.
    ///
    /// * `OFFBOARDING_COMPLETE` - The account has been removed as an Firewall
    ///   Manager administrator.
    status: ?OrganizationStatus = null,

    pub const json_field_names = .{
        .admin_account = "AdminAccount",
        .default_admin = "DefaultAdmin",
        .status = "Status",
    };
};
