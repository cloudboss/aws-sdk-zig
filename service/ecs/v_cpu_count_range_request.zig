/// The minimum and maximum number of vCPUs for instance type selection. This
/// allows you
/// to specify a range of vCPU counts that meet your workload requirements.
pub const VCpuCountRangeRequest = struct {
    /// The maximum number of vCPUs. Instance types with more vCPUs than this value
    /// are
    /// excluded from selection.
    max: ?i32,

    /// The minimum number of vCPUs. Instance types with fewer vCPUs than this value
    /// are
    /// excluded from selection.
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
