const BatchTransformInput = @import("batch_transform_input.zig").BatchTransformInput;
const EndpointInput = @import("endpoint_input.zig").EndpointInput;
const MonitoringGroundTruthS3Input = @import("monitoring_ground_truth_s3_input.zig").MonitoringGroundTruthS3Input;

/// The input for the model quality monitoring job. Currently endpoints are
/// supported for input for model quality monitoring jobs.
pub const ModelQualityJobInput = struct {
    /// Input object for the batch transform job.
    batch_transform_input: ?BatchTransformInput = null,

    endpoint_input: ?EndpointInput = null,

    /// The ground truth label provided for the model.
    ground_truth_s3_input: MonitoringGroundTruthS3Input,

    pub const json_field_names = .{
        .batch_transform_input = "BatchTransformInput",
        .endpoint_input = "EndpointInput",
        .ground_truth_s3_input = "GroundTruthS3Input",
    };
};
