/// Special road types or features that should be considered available for
/// routing. For example, this attribute can be used to allow the use of HOV
/// (high-occupancy vehicle) or HOT (high-occupancy toll) lanes, even if they
/// would otherwise not be.
pub const IsolineAllowOptions = struct {
    /// When true, allows the use of HOT (high-occupancy toll) lanes, which may
    /// affect travel times and reachable areas.
    ///
    /// Default value: `false`
    hot: ?bool = null,

    /// When true, allows the use of HOV (high-occupancy vehicle) lanes, which may
    /// affect travel times and reachable areas.
    ///
    /// Default value: `false`
    hov: ?bool = null,

    pub const json_field_names = .{
        .hot = "Hot",
        .hov = "Hov",
    };
};
