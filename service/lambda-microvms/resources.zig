/// Resource requirements for a MicroVM.
pub const Resources = struct {
    /// The minimum amount of memory in MiB to allocate to the MicroVM.
    minimum_memory_in_mi_b: i32,

    pub const json_field_names = .{
        .minimum_memory_in_mi_b = "minimumMemoryInMiB",
    };
};
