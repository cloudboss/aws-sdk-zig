/// Trailer options corresponding to the vehicle.
pub const RouteTrailerOptions = struct {
    /// Total number of axles of the vehicle.
    axle_count: ?i32 = null,

    /// Number of trailers attached to the vehicle.
    ///
    /// Default value: `0`
    trailer_count: ?i32 = null,

    pub const json_field_names = .{
        .axle_count = "AxleCount",
        .trailer_count = "TrailerCount",
    };
};
