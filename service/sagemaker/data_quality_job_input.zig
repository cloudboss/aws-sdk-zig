const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const EndpointInput = @import("endpoint_input.zig").EndpointInput;

/// The input for the data quality monitoring job. Currently endpoints are
/// supported for input.
pub const DataQualityJobInput = struct {
    /// Input object for the batch transform job.
    batch_transform_input: ?BatchTransformInput = null,

    endpoint_input: ?EndpointInput = null,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .endpoint_input = "EndpointInput",
    };
};
