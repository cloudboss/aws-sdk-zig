/// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
/// Services Inferentia chips)
/// on an instance. To exclude accelerator-enabled instance types, set `Max` to
/// `0`.
pub const AcceleratorCountRequest = struct {
    /// The maximum number of accelerators. To specify no maximum limit, omit this
    /// parameter. To exclude accelerator-enabled instance types, set `Max` to
    /// `0`.
    max: ?i32,

    /// The minimum number of accelerators. To specify no minimum limit, omit this
    /// parameter.
    min: ?i32,
};
