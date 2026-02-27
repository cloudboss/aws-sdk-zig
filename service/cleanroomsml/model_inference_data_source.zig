/// Defines information about the data source used for model inference.
pub const ModelInferenceDataSource = struct {
    /// The Amazon Resource Name (ARN) of the ML input channel for this model
    /// inference data source.
    ml_input_channel_arn: []const u8,

    pub const json_field_names = .{
        .ml_input_channel_arn = "mlInputChannelArn",
    };
};
