const AppCategory = @import("app_category.zig").AppCategory;
const InstancePlatform = @import("instance_platform.zig").InstancePlatform;

/// Describes a bundle, which is a set of specs describing your virtual private
/// server (or
/// *instance*).
pub const Bundle = struct {
    /// The bundle ID (`micro_x_x`).
    bundle_id: ?[]const u8 = null,

    /// The number of vCPUs included in the bundle (`2`).
    cpu_count: ?i32 = null,

    /// The size of the SSD (`30`).
    disk_size_in_gb: ?i32 = null,

    /// The instance type (`micro`).
    instance_type: ?[]const u8 = null,

    /// A Boolean value indicating whether the bundle is active.
    is_active: ?bool = null,

    /// A friendly name for the bundle (`Micro`).
    name: ?[]const u8 = null,

    /// A numeric value that represents the power of the bundle (`500`). You can use
    /// the bundle's power value in conjunction with a blueprint's minimum power
    /// value to determine
    /// whether the blueprint will run on the bundle. For example, you need a bundle
    /// with a power
    /// value of 500 or more to create an instance that uses a blueprint with a
    /// minimum power value of
    /// 500.
    power: ?i32 = null,

    /// The price in US dollars (`5.0`) of the bundle.
    price: ?f32 = null,

    /// An integer that indicates the public ipv4 address count included in the
    /// bundle, the value
    /// is either 0 or 1.
    public_ipv_4_address_count: ?i32 = null,

    /// The amount of RAM in GB (`2.0`).
    ram_size_in_gb: ?f32 = null,

    /// Virtual computer blueprints that are supported by a Lightsail for Research
    /// bundle.
    ///
    /// This parameter only applies to Lightsail for Research resources.
    supported_app_categories: ?[]const AppCategory = null,

    /// The operating system platform (Linux/Unix-based or Windows Server-based)
    /// that the bundle
    /// supports. You can only launch a `WINDOWS` bundle on a blueprint that
    /// supports the
    /// `WINDOWS` platform. `LINUX_UNIX` blueprints require a
    /// `LINUX_UNIX` bundle.
    supported_platforms: ?[]const InstancePlatform = null,

    /// The data transfer rate per month in GB (`2000`).
    transfer_per_month_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .cpu_count = "cpuCount",
        .disk_size_in_gb = "diskSizeInGb",
        .instance_type = "instanceType",
        .is_active = "isActive",
        .name = "name",
        .power = "power",
        .price = "price",
        .public_ipv_4_address_count = "publicIpv4AddressCount",
        .ram_size_in_gb = "ramSizeInGb",
        .supported_app_categories = "supportedAppCategories",
        .supported_platforms = "supportedPlatforms",
        .transfer_per_month_in_gb = "transferPerMonthInGb",
    };
};
