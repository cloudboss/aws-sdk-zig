const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const EndpointInput = @import("endpoint_input.zig").EndpointInput;

/// Inputs for the model explainability job.
pub const ModelExplainabilityJobInput = struct {
    /// Input object for the batch transform job.
    batch_transform_input: ?BatchTransformInput = null,

    endpoint_input: ?EndpointInput = null,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .endpoint_input = "EndpointInput",
    };
};
