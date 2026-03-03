/// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
/// Services Inferentia chips)
/// on an instance.
pub const AcceleratorCount = struct {
    /// The maximum number of accelerators. If this parameter is not specified,
    /// there is no
    /// maximum limit.
    max: ?i32 = null,

    /// The minimum number of accelerators. If this parameter is not specified,
    /// there is no minimum
    /// limit.
    min: ?i32 = null,
};
