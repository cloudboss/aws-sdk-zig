/// The minimum and maximum number of vCPUs.
pub const VCpuCountRangeRequest = struct {
    /// The maximum number of vCPUs. To specify no maximum limit, omit this
    /// parameter.
    max: ?i32,

    /// The minimum number of vCPUs. To specify no minimum limit, specify `0`.
    min: i32,
};
