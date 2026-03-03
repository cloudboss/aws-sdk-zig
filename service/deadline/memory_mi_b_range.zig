/// The range of memory in MiB.
pub const MemoryMiBRange = struct {
    /// The maximum amount of memory (in MiB).
    max: ?i32 = null,

    /// The minimum amount of memory (in MiB).
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
