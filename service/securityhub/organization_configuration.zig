const OrganizationConfigurationConfigurationType = @import("organization_configuration_configuration_type.zig").OrganizationConfigurationConfigurationType;
const OrganizationConfigurationStatus = @import("organization_configuration_status.zig").OrganizationConfigurationStatus;

/// Provides information about the way an organization is configured in Security
/// Hub.
pub const OrganizationConfiguration = struct {
    /// Indicates whether the organization uses local or central configuration.
    ///
    /// If you use local configuration, the
    /// Security Hub delegated administrator can set `AutoEnable` to `true` and
    /// `AutoEnableStandards` to `DEFAULT`. This automatically enables Security Hub
    /// and
    /// default security standards in new organization accounts. These new account
    /// settings must be set separately in
    /// each Amazon Web Services Region, and settings may be different in each
    /// Region.
    ///
    /// If you use central configuration, the delegated administrator can create
    /// configuration policies. Configuration
    /// policies can be used to configure Security Hub, security standards, and
    /// security controls in multiple
    /// accounts and Regions. If you want new organization accounts to use a
    /// specific configuration, you can create a
    /// configuration policy and associate it with the root or specific
    /// organizational units (OUs). New accounts will
    /// inherit the policy from the root or their assigned OU.
    configuration_type: ?OrganizationConfigurationConfigurationType = null,

    /// Describes whether central configuration could be enabled as the
    /// `ConfigurationType` for the
    /// organization. If your `ConfigurationType` is local configuration, then the
    /// value of `Status`
    /// is always `ENABLED`.
    status: ?OrganizationConfigurationStatus = null,

    /// Provides an explanation if the value of `Status` is equal to `FAILED` when
    /// `ConfigurationType`
    /// is equal to `CENTRAL`.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_type = "ConfigurationType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
