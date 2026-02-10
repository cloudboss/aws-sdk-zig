/// The minimum and maximum number of vCPUs.
pub const VCpuCountRange = struct {
    /// The maximum number of vCPUs. If this parameter is not specified, there is no
    /// maximum
    /// limit.
    max: ?i32,

    /// The minimum number of vCPUs. If the value is `0`, there is no minimum
    /// limit.
    min: ?i32,
};
