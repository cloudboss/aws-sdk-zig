pub const PricingPlan = enum {
    /// This pricing plan should be used for request based billing.
    request_based_usage,
    /// This pricing plan must be picked for mobile asset tracking use cases.
    mobile_asset_tracking,
    /// This pricing plan must be picked for mobile asset management use cases
    mobile_asset_management,

    pub const json_field_names = .{
        .request_based_usage = "RequestBasedUsage",
        .mobile_asset_tracking = "MobileAssetTracking",
        .mobile_asset_management = "MobileAssetManagement",
    };
};
