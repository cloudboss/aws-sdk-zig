/// Predictive Dialer config
pub const PredictiveDialerConfig = struct {
    bandwidth_allocation: f64,

    dialing_capacity: ?f64,

    pub const json_field_names = .{
        .bandwidth_allocation = "bandwidthAllocation",
        .dialing_capacity = "dialingCapacity",
    };
};
