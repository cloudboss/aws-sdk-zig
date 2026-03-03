const VolumeType = @import("volume_type.zig").VolumeType;

/// Options to enable, disable, and specify the properties of EBS storage
/// volumes. For more information, see [ Configuring EBS-based
/// Storage](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-ebs).
pub const EBSOptions = struct {
    /// Specifies whether EBS-based storage is enabled.
    ebs_enabled: ?bool = null,

    /// Specifies the IOPS for Provisioned IOPS And GP3 EBS volume (SSD).
    iops: ?i32 = null,

    /// Specifies the Throughput for GP3 EBS volume (SSD).
    throughput: ?i32 = null,

    /// Integer to specify the size of an EBS volume.
    volume_size: ?i32 = null,

    /// Specifies the volume type for EBS-based storage.
    volume_type: ?VolumeType = null,

    pub const json_field_names = .{
        .ebs_enabled = "EBSEnabled",
        .iops = "Iops",
        .throughput = "Throughput",
        .volume_size = "VolumeSize",
        .volume_type = "VolumeType",
    };
};
