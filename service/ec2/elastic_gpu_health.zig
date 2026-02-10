const ElasticGpuStatus = @import("elastic_gpu_status.zig").ElasticGpuStatus;

/// **Note:**
///
/// Amazon Elastic Graphics reached end of life on January 8, 2024.
///
/// Describes the status of an Elastic Graphics accelerator.
pub const ElasticGpuHealth = struct {
    /// The health status.
    status: ?ElasticGpuStatus,
};
