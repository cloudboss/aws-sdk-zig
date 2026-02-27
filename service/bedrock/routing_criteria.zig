/// Routing criteria for a prompt router.
pub const RoutingCriteria = struct {
    /// The criteria's response quality difference.
    response_quality_difference: f64,

    pub const json_field_names = .{
        .response_quality_difference = "responseQualityDifference",
    };
};
