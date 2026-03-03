const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// Contains the tracker resource details.
pub const ListTrackersResponseEntry = struct {
    /// The timestamp for when the tracker resource was created in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The description for the tracker resource.
    description: []const u8,

    /// Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// No longer used. Always returns an empty string.
    pricing_plan_data_source: ?[]const u8 = null,

    /// The name of the tracker resource.
    tracker_name: []const u8,

    /// The timestamp at which the device's position was determined. Uses [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .description = "Description",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tracker_name = "TrackerName",
        .update_time = "UpdateTime",
    };
};
