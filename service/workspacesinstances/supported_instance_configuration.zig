const BillingMode = @import("billing_mode.zig").BillingMode;
const PlatformTypeEnum = @import("platform_type_enum.zig").PlatformTypeEnum;
const InstanceConfigurationTenancyEnum = @import("instance_configuration_tenancy_enum.zig").InstanceConfigurationTenancyEnum;

/// Represents a single valid configuration combination that an instance type
/// supports, combining tenancy, platform type, and billing mode into one
/// complete configuration specification.
pub const SupportedInstanceConfiguration = struct {
    /// Specifies the billing mode supported in this configuration combination.
    billing_mode: ?BillingMode,

    /// Specifies the operating system platform supported in this configuration
    /// combination.
    platform_type: ?PlatformTypeEnum,

    /// Specifies the tenancy model supported in this configuration combination.
    tenancy: ?InstanceConfigurationTenancyEnum,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
        .platform_type = "PlatformType",
        .tenancy = "Tenancy",
    };
};
