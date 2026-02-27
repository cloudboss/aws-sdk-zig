const BillingMode = @import("billing_mode.zig").BillingMode;
const PlatformTypeEnum = @import("platform_type_enum.zig").PlatformTypeEnum;
const InstanceConfigurationTenancyEnum = @import("instance_configuration_tenancy_enum.zig").InstanceConfigurationTenancyEnum;

/// Defines filtering criteria for WorkSpace Instance type searches. Combines
/// multiple filter conditions including billing mode, platform type, and
/// tenancy to help customers find instance types that meet their specific
/// requirements.
pub const InstanceConfigurationFilter = struct {
    /// Filters WorkSpace Instance types based on supported billing modes. Allows
    /// customers to search for instance types that support their preferred billing
    /// model, such as HOURLY or MONTHLY billing.
    billing_mode: BillingMode,

    /// Filters WorkSpace Instance types by operating system platform. Allows
    /// customers to find instances that support their desired OS, such as Windows,
    /// Linux/UNIX, Ubuntu Pro, RHEL, or SUSE.
    platform_type: PlatformTypeEnum,

    /// Filters WorkSpace Instance types by tenancy model. Allows customers to find
    /// instances that match their tenancy requirements, such as SHARED or
    /// DEDICATED.
    tenancy: InstanceConfigurationTenancyEnum,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
        .platform_type = "PlatformType",
        .tenancy = "Tenancy",
    };
};
