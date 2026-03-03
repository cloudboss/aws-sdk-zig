/// An instance type that the specified Amazon EMR release supports.
pub const SupportedInstanceType = struct {
    /// The CPU architecture, for example `X86_64` or `AARCH64`.
    architecture: ?[]const u8 = null,

    /// Indicates whether the `SupportedInstanceType` supports Amazon EBS
    /// optimization.
    ebs_optimized_available: ?bool = null,

    /// Indicates whether the `SupportedInstanceType` uses Amazon EBS
    /// optimization by default.
    ebs_optimized_by_default: ?bool = null,

    /// Indicates whether the `SupportedInstanceType` only supports Amazon EBS.
    ebs_storage_only: ?bool = null,

    /// The Amazon EC2 family and generation for the
    /// `SupportedInstanceType`.
    instance_family_id: ?[]const u8 = null,

    /// Indicates whether the `SupportedInstanceType` only supports 64-bit
    /// architecture.
    is_64_bits_only: ?bool = null,

    /// The amount of memory that is available to Amazon EMR from the
    /// `SupportedInstanceType`. The kernel and hypervisor
    /// software consume some memory, so this value might be lower than the overall
    /// memory for the
    /// instance type.
    memory_gb: ?f32 = null,

    /// Number of disks for the `SupportedInstanceType`. This value is `0`
    /// for Amazon EBS-only instance types.
    number_of_disks: ?i32 = null,

    /// `StorageGB` represents the storage capacity of the
    /// `SupportedInstanceType`. This value is `0` for Amazon EBS-only instance
    /// types.
    storage_gb: ?i32 = null,

    /// The [Amazon EC2 instance
    /// type](http://aws.amazon.com/ec2/instance-types/), for example `m5.xlarge`,
    /// of the
    /// `SupportedInstanceType`.
    @"type": ?[]const u8 = null,

    /// The number of vCPUs available for the `SupportedInstanceType`.
    vcpu: ?i32 = null,

    pub const json_field_names = .{
        .architecture = "Architecture",
        .ebs_optimized_available = "EbsOptimizedAvailable",
        .ebs_optimized_by_default = "EbsOptimizedByDefault",
        .ebs_storage_only = "EbsStorageOnly",
        .instance_family_id = "InstanceFamilyId",
        .is_64_bits_only = "Is64BitsOnly",
        .memory_gb = "MemoryGB",
        .number_of_disks = "NumberOfDisks",
        .storage_gb = "StorageGB",
        .@"type" = "Type",
        .vcpu = "VCPU",
    };
};
