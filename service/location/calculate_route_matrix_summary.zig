const DistanceUnit = @import("distance_unit.zig").DistanceUnit;

/// A summary of the calculated route matrix.
pub const CalculateRouteMatrixSummary = struct {
    /// The data provider of traffic and road network data used to calculate the
    /// routes. Indicates one of the available providers:
    ///
    /// * `Esri`
    /// * `Grab`
    /// * `Here`
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// The unit of measurement for route distances.
    distance_unit: DistanceUnit,

    /// The count of error results in the route matrix. If this number is 0, all
    /// routes were calculated successfully.
    error_count: i32,

    /// The count of cells in the route matrix. Equal to the number of
    /// `DeparturePositions` multiplied by the number of `DestinationPositions`.
    route_count: i32,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .distance_unit = "DistanceUnit",
        .error_count = "ErrorCount",
        .route_count = "RouteCount",
    };
};
