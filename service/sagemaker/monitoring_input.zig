const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const EndpointInput = @import("endpoint_input.zig").EndpointInput;

/// The inputs for a monitoring job.
pub const MonitoringInput = struct {
    /// Input object for the batch transform job.
    batch_transform_input: ?BatchTransformInput,

    /// The endpoint for a monitoring job.
    endpoint_input: ?EndpointInput,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .endpoint_input = "EndpointInput",
    };
};
