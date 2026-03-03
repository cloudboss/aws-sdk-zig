const AutomatedDiscoveryInformation = @import("automated_discovery_information.zig").AutomatedDiscoveryInformation;
const ConsumedLicenseSummary = @import("consumed_license_summary.zig").ConsumedLicenseSummary;
const LicenseCountingType = @import("license_counting_type.zig").LicenseCountingType;
const ManagedResourceSummary = @import("managed_resource_summary.zig").ManagedResourceSummary;
const ProductInformation = @import("product_information.zig").ProductInformation;

/// A license configuration is an abstraction of a customer license agreement
/// that can be
/// consumed and enforced by License Manager. Components include specifications
/// for the license
/// type (licensing by instance, socket, CPU, or vCPU), allowed tenancy (shared
/// tenancy,
/// Dedicated Instance, Dedicated Host, or all of these), host affinity (how
/// long a VM
/// must be associated with a host), and the number of licenses purchased and
/// used.
pub const LicenseConfiguration = struct {
    /// Automated discovery information.
    automated_discovery_information: ?AutomatedDiscoveryInformation = null,

    /// Number of licenses consumed.
    consumed_licenses: ?i64 = null,

    /// Summaries for licenses consumed by various resources.
    consumed_license_summary_list: ?[]const ConsumedLicenseSummary = null,

    /// Description of the license configuration.
    description: ?[]const u8 = null,

    /// When true, disassociates a resource when software is uninstalled.
    disassociate_when_not_found: ?bool = null,

    /// Amazon Resource Name (ARN) of the license configuration.
    license_configuration_arn: ?[]const u8 = null,

    /// Unique ID of the license configuration.
    license_configuration_id: ?[]const u8 = null,

    /// Number of licenses managed by the license configuration.
    license_count: ?i64 = null,

    /// Number of available licenses as a hard limit.
    license_count_hard_limit: ?bool = null,

    /// Dimension to use to track the license inventory.
    license_counting_type: ?LicenseCountingType = null,

    /// License configuration expiry time in Unix timestamp format.
    license_expiry: ?i64 = null,

    /// License rules.
    license_rules: ?[]const []const u8 = null,

    /// Summaries for managed resources.
    managed_resource_summary_list: ?[]const ManagedResourceSummary = null,

    /// Name of the license configuration.
    name: ?[]const u8 = null,

    /// Account ID of the license configuration's owner.
    owner_account_id: ?[]const u8 = null,

    /// Product information.
    product_information_list: ?[]const ProductInformation = null,

    /// Status of the license configuration.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .automated_discovery_information = "AutomatedDiscoveryInformation",
        .consumed_licenses = "ConsumedLicenses",
        .consumed_license_summary_list = "ConsumedLicenseSummaryList",
        .description = "Description",
        .disassociate_when_not_found = "DisassociateWhenNotFound",
        .license_configuration_arn = "LicenseConfigurationArn",
        .license_configuration_id = "LicenseConfigurationId",
        .license_count = "LicenseCount",
        .license_count_hard_limit = "LicenseCountHardLimit",
        .license_counting_type = "LicenseCountingType",
        .license_expiry = "LicenseExpiry",
        .license_rules = "LicenseRules",
        .managed_resource_summary_list = "ManagedResourceSummaryList",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .product_information_list = "ProductInformationList",
        .status = "Status",
    };
};
