const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// A place index resource listed in your Amazon Web Services account.
pub const ListPlaceIndexesResponseEntry = struct {
    /// The timestamp for when the place index resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The data provider of geospatial data. Values can be one of the following:
    ///
    /// * `Esri`
    /// * `Grab`
    /// * `Here`
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// The optional description for the place index resource.
    description: []const u8,

    /// The name of the place index resource.
    index_name: []const u8,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// The timestamp for when the place index resource was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .data_source = "DataSource",
        .description = "Description",
        .index_name = "IndexName",
        .pricing_plan = "PricingPlan",
        .update_time = "UpdateTime",
    };
};
