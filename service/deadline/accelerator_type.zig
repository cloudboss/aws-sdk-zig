pub const AcceleratorType = enum {
    /// GPU accelerator type.
    gpu,

    pub const json_field_names = .{
        .gpu = "GPU",
    };
};
