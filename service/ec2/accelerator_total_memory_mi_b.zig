/// The minimum and maximum amount of total accelerator memory, in MiB.
pub const AcceleratorTotalMemoryMiB = struct {
    /// The maximum amount of accelerator memory, in MiB. If this parameter is not
    /// specified,
    /// there is no maximum limit.
    max: ?i32 = null,

    /// The minimum amount of accelerator memory, in MiB. If this parameter is not
    /// specified,
    /// there is no minimum limit.
    min: ?i32 = null,
};
