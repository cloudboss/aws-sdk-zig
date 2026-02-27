const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// Contains the geofence collection details.
///
/// The returned geometry will always match the geometry format used when the
/// geofence was created.
pub const ListGeofenceCollectionsResponseEntry = struct {
    /// The name of the geofence collection.
    collection_name: []const u8,

    /// The timestamp for when the geofence collection was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The description for the geofence collection
    description: []const u8,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan,

    /// No longer used. Always returns an empty string.
    pricing_plan_data_source: ?[]const u8,

    /// Specifies a timestamp for when the resource was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .create_time = "CreateTime",
        .description = "Description",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .update_time = "UpdateTime",
    };
};
