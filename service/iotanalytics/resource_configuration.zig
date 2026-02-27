const ComputeType = @import("compute_type.zig").ComputeType;

/// The configuration of the resource used to execute the `containerAction`.
pub const ResourceConfiguration = struct {
    /// The type of the compute resource used to execute the `containerAction`.
    /// Possible values are: `ACU_1` (vCPU=4, memory=16 GiB) or `ACU_2` (vCPU=8,
    /// memory=32 GiB).
    compute_type: ComputeType,

    /// The size, in GB, of the persistent storage available to the resource
    /// instance used to
    /// execute the `containerAction` (min: 1, max: 50).
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .compute_type = "computeType",
        .volume_size_in_gb = "volumeSizeInGB",
    };
};
