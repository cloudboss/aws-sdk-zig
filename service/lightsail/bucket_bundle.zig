/// Describes the specifications of a bundle that can be applied to an Amazon
/// Lightsail
/// bucket.
///
/// A bucket bundle specifies the monthly cost, storage space, and data transfer
/// quota for a
/// bucket.
pub const BucketBundle = struct {
    /// The ID of the bundle.
    bundle_id: ?[]const u8,

    /// Indicates whether the bundle is active. Use for a new or existing bucket.
    is_active: ?bool,

    /// The name of the bundle.
    name: ?[]const u8,

    /// The monthly price of the bundle, in US dollars.
    price: ?f32,

    /// The storage size of the bundle, in GB.
    storage_per_month_in_gb: ?i32,

    /// The monthly network transfer quota of the bundle.
    transfer_per_month_in_gb: ?i32,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .is_active = "isActive",
        .name = "name",
        .price = "price",
        .storage_per_month_in_gb = "storagePerMonthInGb",
        .transfer_per_month_in_gb = "transferPerMonthInGb",
    };
};
