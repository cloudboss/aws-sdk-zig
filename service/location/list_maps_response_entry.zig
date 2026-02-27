const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// Contains details of an existing map resource in your Amazon Web Services
/// account.
pub const ListMapsResponseEntry = struct {
    /// The timestamp for when the map resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// Specifies the data provider for the associated map tiles.
    data_source: []const u8,

    /// The description for the map resource.
    description: []const u8,

    /// The name of the associated map resource.
    map_name: []const u8,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan,

    /// The timestamp for when the map resource was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .data_source = "DataSource",
        .description = "Description",
        .map_name = "MapName",
        .pricing_plan = "PricingPlan",
        .update_time = "UpdateTime",
    };
};
