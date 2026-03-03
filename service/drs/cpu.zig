/// Information about a server's CPU.
pub const CPU = struct {
    /// The number of CPU cores.
    cores: i64 = 0,

    /// The model name of the CPU.
    model_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cores = "cores",
        .model_name = "modelName",
    };
};
