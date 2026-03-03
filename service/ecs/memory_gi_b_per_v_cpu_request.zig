/// The minimum and maximum amount of memory per vCPU in gibibytes (GiB). This
/// helps
/// ensure that instance types have the appropriate memory-to-CPU ratio for your
/// workloads.
pub const MemoryGiBPerVCpuRequest = struct {
    /// The maximum amount of memory per vCPU in GiB. Instance types with a higher
    /// memory-to-vCPU ratio are excluded from selection.
    max: ?f64 = null,

    /// The minimum amount of memory per vCPU in GiB. Instance types with a lower
    /// memory-to-vCPU ratio are excluded from selection.
    min: ?f64 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
