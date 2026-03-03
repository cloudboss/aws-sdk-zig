/// The minimum and maximum total accelerator memory in mebibytes (MiB) for
/// instance type
/// selection. This is important for GPU workloads that require specific amounts
/// of video
/// memory.
pub const AcceleratorTotalMemoryMiBRequest = struct {
    /// The maximum total accelerator memory in MiB. Instance types with more
    /// accelerator
    /// memory are excluded from selection.
    max: ?i32 = null,

    /// The minimum total accelerator memory in MiB. Instance types with less
    /// accelerator
    /// memory are excluded from selection.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
