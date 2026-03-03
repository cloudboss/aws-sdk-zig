/// Defines the maximum and minimum amount of memory, in MiB, to use for the
/// accelerator.
pub const AcceleratorTotalMemoryMiBRange = struct {
    /// The maximum amount of memory to use for the accelerator, measured in MiB.
    max: ?i32 = null,

    /// The minimum amount of memory to use for the accelerator, measured in MiB.
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
