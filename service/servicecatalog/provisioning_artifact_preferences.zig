/// The user-defined preferences that will be applied during product
/// provisioning, unless overridden by `ProvisioningPreferences` or
/// `UpdateProvisioningPreferences`.
///
/// For more information on maximum concurrent accounts and failure tolerance,
/// see [Stack set operation
/// options](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options) in the *CloudFormation User Guide*.
pub const ProvisioningArtifactPreferences = struct {
    /// One or more Amazon Web Services accounts where stack instances are deployed
    /// from the stack set. These accounts can be scoped in
    /// `ProvisioningPreferences$StackSetAccounts` and
    /// `UpdateProvisioningPreferences$StackSetAccounts`.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    stack_set_accounts: ?[]const []const u8,

    /// One or more Amazon Web Services Regions where stack instances are deployed
    /// from the stack set. These Regions can be scoped in
    /// `ProvisioningPreferences$StackSetRegions` and
    /// `UpdateProvisioningPreferences$StackSetRegions`.
    ///
    /// Applicable only to a `CFN_STACKSET` provisioned product type.
    stack_set_regions: ?[]const []const u8,

    pub const json_field_names = .{
        .stack_set_accounts = "StackSetAccounts",
        .stack_set_regions = "StackSetRegions",
    };
};
