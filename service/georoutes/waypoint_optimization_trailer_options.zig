/// Trailer options corresponding to the vehicle.
pub const WaypointOptimizationTrailerOptions = struct {
    /// Number of trailers attached to the vehicle.
    ///
    /// Default Value: `0`
    trailer_count: ?i32,

    pub const json_field_names = .{
        .trailer_count = "TrailerCount",
    };
};
