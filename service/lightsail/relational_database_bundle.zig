/// Describes a database bundle. A bundle describes the performance
/// specifications of the
/// database.
pub const RelationalDatabaseBundle = struct {
    /// The ID for the database bundle.
    bundle_id: ?[]const u8 = null,

    /// The number of virtual CPUs (vCPUs) for the database bundle.
    cpu_count: ?i32 = null,

    /// The size of the disk for the database bundle.
    disk_size_in_gb: ?i32 = null,

    /// A Boolean value indicating whether the database bundle is active.
    is_active: ?bool = null,

    /// A Boolean value indicating whether the database bundle is encrypted.
    is_encrypted: ?bool = null,

    /// The name for the database bundle.
    name: ?[]const u8 = null,

    /// The cost of the database bundle in US currency.
    price: ?f32 = null,

    /// The amount of RAM in GB (for example, `2.0`) for the database bundle.
    ram_size_in_gb: ?f32 = null,

    /// The data transfer rate per month in GB for the database bundle.
    transfer_per_month_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .cpu_count = "cpuCount",
        .disk_size_in_gb = "diskSizeInGb",
        .is_active = "isActive",
        .is_encrypted = "isEncrypted",
        .name = "name",
        .price = "price",
        .ram_size_in_gb = "ramSizeInGb",
        .transfer_per_month_in_gb = "transferPerMonthInGb",
    };
};
