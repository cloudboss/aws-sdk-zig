const ModelSource = @import("model_source.zig").ModelSource;

/// The Amazon SageMaker model.
pub const ExternalModelSummary = struct {
    /// The endpoint of the Amazon SageMaker model.
    model_endpoint: ?[]const u8 = null,

    /// The source of the model.
    model_source: ?ModelSource = null,

    pub const json_field_names = .{
        .model_endpoint = "modelEndpoint",
        .model_source = "modelSource",
    };
};
