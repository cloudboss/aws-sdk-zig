/// Progressive config
pub const ProgressiveConfig = struct {
    bandwidth_allocation: f64,

    pub const json_field_names = .{
        .bandwidth_allocation = "bandwidthAllocation",
    };
};
