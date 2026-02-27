/// The model on the edge device.
pub const EdgeModel = struct {
    /// The timestamp of the last inference that was made.
    latest_inference: ?i64,

    /// The timestamp of the last data sample taken.
    latest_sample_time: ?i64,

    /// The name of the model.
    model_name: []const u8,

    /// The model version.
    model_version: []const u8,

    pub const json_field_names = .{
        .latest_inference = "LatestInference",
        .latest_sample_time = "LatestSampleTime",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};
