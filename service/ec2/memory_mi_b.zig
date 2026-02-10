/// The minimum and maximum amount of memory, in MiB.
pub const MemoryMiB = struct {
    /// The maximum amount of memory, in MiB. If this parameter is not specified,
    /// there is no
    /// maximum limit.
    max: ?i32,

    /// The minimum amount of memory, in MiB. If this parameter is not specified,
    /// there is no minimum
    /// limit.
    min: ?i32,
};
