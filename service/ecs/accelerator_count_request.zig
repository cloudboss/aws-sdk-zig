/// The minimum and maximum number of accelerators (such as GPUs) for instance
/// type selection. This is used for workloads that require specific numbers of
/// accelerators.
pub const AcceleratorCountRequest = struct {
    /// The maximum number of accelerators. Instance types with more accelerators
    /// are excluded from selection.
    max: ?i32 = null,

    /// The minimum number of accelerators. Instance types with fewer accelerators
    /// are excluded from selection.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
