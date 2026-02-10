const ElasticGpuHealth = @import("elastic_gpu_health.zig").ElasticGpuHealth;
const ElasticGpuState = @import("elastic_gpu_state.zig").ElasticGpuState;
const Tag = @import("tag.zig").Tag;

/// **Note:**
///
/// Amazon Elastic Graphics reached end of life on January 8, 2024.
///
/// Describes an Elastic Graphics accelerator.
pub const ElasticGpus = struct {
    /// The Availability Zone in the which the Elastic Graphics accelerator resides.
    availability_zone: ?[]const u8,

    /// The status of the Elastic Graphics accelerator.
    elastic_gpu_health: ?ElasticGpuHealth,

    /// The ID of the Elastic Graphics accelerator.
    elastic_gpu_id: ?[]const u8,

    /// The state of the Elastic Graphics accelerator.
    elastic_gpu_state: ?ElasticGpuState,

    /// The type of Elastic Graphics accelerator.
    elastic_gpu_type: ?[]const u8,

    /// The ID of the instance to which the Elastic Graphics accelerator is
    /// attached.
    instance_id: ?[]const u8,

    /// The tags assigned to the Elastic Graphics accelerator.
    tags: ?[]const Tag,
};
