/// The minimum and maximum amount of total accelerator memory, in MiB.
pub const AcceleratorTotalMemoryMiBRequest = struct {
    /// The maximum amount of accelerator memory, in MiB. To specify no maximum
    /// limit, omit this
    /// parameter.
    max: ?i32,

    /// The minimum amount of accelerator memory, in MiB. To specify no minimum
    /// limit, omit this
    /// parameter.
    min: ?i32,
};
