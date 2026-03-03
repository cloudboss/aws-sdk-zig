/// Features that are allowed while calculating a route.
pub const RouteAllowOptions = struct {
    /// Allow Hot (High Occupancy Toll) lanes while calculating the route.
    ///
    /// Default value: `false`
    hot: ?bool = null,

    /// Allow Hov (High Occupancy vehicle) lanes while calculating the route.
    ///
    /// Default value: `false`
    hov: ?bool = null,

    pub const json_field_names = .{
        .hot = "Hot",
        .hov = "Hov",
    };
};
