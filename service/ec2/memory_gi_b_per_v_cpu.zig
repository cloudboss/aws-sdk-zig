/// The minimum and maximum amount of memory per vCPU, in GiB.
pub const MemoryGiBPerVCpu = struct {
    /// The maximum amount of memory per vCPU, in GiB. If this parameter is not
    /// specified, there is
    /// no maximum limit.
    max: ?f64 = null,

    /// The minimum amount of memory per vCPU, in GiB. If this parameter is not
    /// specified, there is
    /// no minimum limit.
    min: ?f64 = null,
};
