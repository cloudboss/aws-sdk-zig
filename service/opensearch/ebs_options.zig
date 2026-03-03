const VolumeType = @import("volume_type.zig").VolumeType;

/// Container for the parameters required to enable EBS-based storage for an
/// OpenSearch
/// Service domain.
pub const EBSOptions = struct {
    /// Indicates whether EBS volumes are attached to data nodes in an OpenSearch
    /// Service
    /// domain.
    ebs_enabled: ?bool = null,

    /// Specifies the baseline input/output (I/O) performance of EBS volumes
    /// attached to data
    /// nodes. Applicable only for the `gp3` and provisioned IOPS EBS volume
    /// types.
    iops: ?i32 = null,

    /// Specifies the throughput (in MiB/s) of the EBS volumes attached to data
    /// nodes.
    /// Applicable only for the `gp3` volume type.
    throughput: ?i32 = null,

    /// Specifies the size (in GiB) of EBS volumes attached to data nodes.
    volume_size: ?i32 = null,

    /// Specifies the type of EBS volumes attached to data nodes.
    volume_type: ?VolumeType = null,

    pub const json_field_names = .{
        .ebs_enabled = "EBSEnabled",
        .iops = "Iops",
        .throughput = "Throughput",
        .volume_size = "VolumeSize",
        .volume_type = "VolumeType",
    };
};
