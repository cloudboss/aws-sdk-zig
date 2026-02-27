/// Features that are allowed while calculating an isoline.
pub const IsolineAllowOptions = struct {
    /// Allow Hot (High Occupancy Toll) lanes while calculating an isoline.
    ///
    /// Default value: `false`
    hot: ?bool,

    /// Allow Hov (High Occupancy vehicle) lanes while calculating an isoline.
    ///
    /// Default value: `false`
    hov: ?bool,

    pub const json_field_names = .{
        .hot = "Hot",
        .hov = "Hov",
    };
};
