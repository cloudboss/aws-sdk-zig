const ModelSource = @import("model_source.zig").ModelSource;

/// The Amazon SageMaker model.
pub const ExternalModelSummary = struct {
    /// The endpoint of the Amazon SageMaker model.
    model_endpoint: ?[]const u8,

    /// The source of the model.
    model_source: ?ModelSource,

    pub const json_field_names = .{
        .model_endpoint = "modelEndpoint",
        .model_source = "modelSource",
    };
};
