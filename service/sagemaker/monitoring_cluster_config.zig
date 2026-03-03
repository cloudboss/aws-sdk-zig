const ProcessingInstanceType = @import("processing_instance_type.zig").ProcessingInstanceType;

/// Configuration for the cluster used to run model monitoring jobs.
pub const MonitoringClusterConfig = struct {
    /// The number of ML compute instances to use in the model monitoring job. For
    /// distributed processing jobs, specify a value greater than 1. The default
    /// value is 1.
    instance_count: i32,

    /// The ML compute instance type for the processing job.
    instance_type: ProcessingInstanceType,

    /// The Key Management Service (KMS) key that Amazon SageMaker AI uses to
    /// encrypt data on the storage volume attached to the ML compute instance(s)
    /// that run the model monitoring job.
    volume_kms_key_id: ?[]const u8 = null,

    /// The size of the ML storage volume, in gigabytes, that you want to provision.
    /// You must specify sufficient ML storage for your scenario.
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
