/// The minimum and maximum amount of memory, in MiB.
pub const MemoryMiBRequest = struct {
    /// The maximum amount of memory, in MiB. To specify no maximum limit, omit this
    /// parameter.
    max: ?i32,

    /// The minimum amount of memory, in MiB. To specify no minimum limit, specify
    /// `0`.
    min: i32,
};
