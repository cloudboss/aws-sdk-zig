/// Input object for the model.
pub const ModelInput = struct {
    /// The input configuration object for the model.
    data_input_config: []const u8,

    pub const json_field_names = .{
        .data_input_config = "DataInputConfig",
    };
};
