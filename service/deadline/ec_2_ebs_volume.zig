/// Specifies the EBS volume.
pub const Ec2EbsVolume = struct {
    /// The IOPS per volume.
    iops: i32 = 3000,

    /// The EBS volume size in GiB.
    size_gi_b: i32 = 250,

    /// The throughput per volume in MiB.
    throughput_mi_b: i32 = 125,

    pub const json_field_names = .{
        .iops = "iops",
        .size_gi_b = "sizeGiB",
        .throughput_mi_b = "throughputMiB",
    };
};
