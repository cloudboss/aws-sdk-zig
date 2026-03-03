/// The minimum and maximum amount of memory in mebibytes (MiB) for instance
/// type
/// selection. This ensures that selected instance types have adequate memory
/// for your
/// workloads.
pub const MemoryMiBRequest = struct {
    /// The maximum amount of memory in MiB. Instance types with more memory than
    /// this value
    /// are excluded from selection.
    max: ?i32 = null,

    /// The minimum amount of memory in MiB. Instance types with less memory than
    /// this value
    /// are excluded from selection.
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
