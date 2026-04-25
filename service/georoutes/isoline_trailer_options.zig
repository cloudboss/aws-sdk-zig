/// Additional specifications when the vehicle includes one or more trailers.
pub const IsolineTrailerOptions = struct {
    /// The total number of axles across all trailers. Used for weight distribution
    /// calculations and road restrictions.
    axle_count: ?i32 = null,

    /// The number of trailers being pulled. Affects which roads can be used based
    /// on local regulations.
    ///
    /// Default value: `0`
    trailer_count: ?i32 = null,

    pub const json_field_names = .{
        .axle_count = "AxleCount",
        .trailer_count = "TrailerCount",
    };
};
