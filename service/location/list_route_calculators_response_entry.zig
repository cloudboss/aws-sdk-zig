const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// A route calculator resource listed in your Amazon Web Services account.
pub const ListRouteCalculatorsResponseEntry = struct {
    /// The name of the route calculator resource.
    calculator_name: []const u8,

    /// The timestamp when the route calculator resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    ///
    /// * For example, `2020–07-2T12:15:20.000Z+01:00`
    create_time: i64,

    /// The data provider of traffic and road network data. Indicates one of the
    /// available providers:
    ///
    /// * `Esri`
    /// * `Grab`
    /// * `Here`
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// The optional description of the route calculator resource.
    description: []const u8,

    /// Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan,

    /// The timestamp when the route calculator resource was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    ///
    /// * For example, `2020–07-2T12:15:20.000Z+01:00`
    update_time: i64,

    pub const json_field_names = .{
        .calculator_name = "CalculatorName",
        .create_time = "CreateTime",
        .data_source = "DataSource",
        .description = "Description",
        .pricing_plan = "PricingPlan",
        .update_time = "UpdateTime",
    };
};
