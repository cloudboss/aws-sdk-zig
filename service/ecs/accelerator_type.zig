pub const AcceleratorType = enum {
    gpu,
    fpga,
    inference,

    pub const json_field_names = .{
        .gpu = "GPU",
        .fpga = "FPGA",
        .inference = "INFERENCE",
    };
};
