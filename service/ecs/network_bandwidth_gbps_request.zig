/// The minimum and maximum network bandwidth in gigabits per second (Gbps) for
/// instance
/// type selection. This is important for network-intensive workloads.
pub const NetworkBandwidthGbpsRequest = struct {
    /// The maximum network bandwidth in Gbps. Instance types with higher network
    /// bandwidth
    /// are excluded from selection.
    max: ?f64,

    /// The minimum network bandwidth in Gbps. Instance types with lower network
    /// bandwidth are
    /// excluded from selection.
    min: ?f64,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
