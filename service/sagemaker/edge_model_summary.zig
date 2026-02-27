/// Summary of model on edge device.
pub const EdgeModelSummary = struct {
    /// The name of the model.
    model_name: []const u8,

    /// The version model.
    model_version: []const u8,

    pub const json_field_names = .{
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};
