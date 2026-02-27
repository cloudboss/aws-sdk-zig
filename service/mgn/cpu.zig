/// Source server CPU information.
pub const CPU = struct {
    /// The number of CPU cores on the source server.
    cores: i64 = 0,

    /// The source server's CPU model name.
    model_name: ?[]const u8,

    pub const json_field_names = .{
        .cores = "cores",
        .model_name = "modelName",
    };
};
