const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const EndpointInput = @import("endpoint_input.zig").EndpointInput;
const MonitoringGroundTruthS3Input = @import("monitoring_ground_truth_s3_input.zig").MonitoringGroundTruthS3Input;

/// Inputs for the model bias job.
pub const ModelBiasJobInput = struct {
    /// Input object for the batch transform job.
    batch_transform_input: ?BatchTransformInput,

    endpoint_input: ?EndpointInput,

    /// Location of ground truth labels to use in model bias job.
    ground_truth_s3_input: MonitoringGroundTruthS3Input,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .endpoint_input = "EndpointInput",
        .ground_truth_s3_input = "GroundTruthS3Input",
    };
};
