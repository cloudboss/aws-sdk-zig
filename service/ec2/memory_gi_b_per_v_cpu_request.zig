/// The minimum and maximum amount of memory per vCPU, in GiB.
pub const MemoryGiBPerVCpuRequest = struct {
    /// The maximum amount of memory per vCPU, in GiB. To specify no maximum limit,
    /// omit this
    /// parameter.
    max: ?f64 = null,

    /// The minimum amount of memory per vCPU, in GiB. To specify no minimum limit,
    /// omit this
    /// parameter.
    min: ?f64 = null,
};
