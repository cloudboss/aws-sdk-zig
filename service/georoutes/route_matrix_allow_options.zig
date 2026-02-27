/// Allow Options related to the route matrix.
pub const RouteMatrixAllowOptions = struct {
    /// Allow Hot (High Occupancy Toll) lanes while calculating the route.
    ///
    /// Default value: `false`
    hot: ?bool,

    /// Allow Hov (High Occupancy vehicle) lanes while calculating the route.
    ///
    /// Default value: `false`
    hov: ?bool,

    pub const json_field_names = .{
        .hot = "Hot",
        .hov = "Hov",
    };
};
