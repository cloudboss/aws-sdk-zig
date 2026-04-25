/// The minimum and maximum baseline Amazon EBS bandwidth in megabits per second
/// (Mbps) for instance type selection. This is important for workloads with
/// high storage I/O requirements.
pub const BaselineEbsBandwidthMbpsRequest = struct {
    /// The maximum baseline Amazon EBS bandwidth in Mbps. Instance types with
    /// higher Amazon EBS bandwidth are excluded from selection.
    max: ?i32 = null,

    /// The minimum baseline Amazon EBS bandwidth in Mbps. Instance types with lower
    /// Amazon EBS bandwidth are excluded from selection.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
