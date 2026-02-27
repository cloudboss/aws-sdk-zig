/// Predictive config
pub const PredictiveConfig = struct {
    bandwidth_allocation: f64,

    pub const json_field_names = .{
        .bandwidth_allocation = "bandwidthAllocation",
    };
};
