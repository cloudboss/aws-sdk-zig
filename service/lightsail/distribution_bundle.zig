/// Describes the specifications of a distribution bundle.
pub const DistributionBundle = struct {
    /// The ID of the bundle.
    bundle_id: ?[]const u8 = null,

    /// Indicates whether the bundle is active, and can be specified for a new or
    /// existing
    /// distribution.
    is_active: ?bool = null,

    /// The name of the distribution bundle.
    name: ?[]const u8 = null,

    /// The monthly price, in US dollars, of the bundle.
    price: ?f32 = null,

    /// The monthly network transfer quota of the bundle.
    transfer_per_month_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .is_active = "isActive",
        .name = "name",
        .price = "price",
        .transfer_per_month_in_gb = "transferPerMonthInGb",
    };
};
