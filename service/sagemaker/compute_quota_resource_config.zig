const AcceleratorPartitionConfig = @import("accelerator_partition_config.zig").AcceleratorPartitionConfig;
const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// Configuration of the resources used for the compute allocation definition.
pub const ComputeQuotaResourceConfig = struct {
    /// The accelerator partition configuration for fractional GPU allocation.
    accelerator_partition: ?AcceleratorPartitionConfig,

    /// The number of accelerators to allocate. If you don't specify a value for
    /// vCPU and MemoryInGiB, SageMaker AI automatically allocates ratio-based
    /// values for those parameters based on the number of accelerators you provide.
    /// For example, if you allocate 16 out of 32 total accelerators, SageMaker AI
    /// uses the ratio of 0.5 and allocates values to vCPU and MemoryInGiB.
    accelerators: ?i32,

    /// The number of instances to add to the instance group of a SageMaker HyperPod
    /// cluster.
    count: ?i32,

    /// The instance type of the instance group for the cluster.
    instance_type: ClusterInstanceType,

    /// The amount of memory in GiB to allocate. If you specify a value only for
    /// this parameter, SageMaker AI automatically allocates a ratio-based value for
    /// vCPU based on this memory that you provide. For example, if you allocate 200
    /// out of 400 total memory in GiB, SageMaker AI uses the ratio of 0.5 and
    /// allocates values to vCPU. Accelerators are set to 0.
    memory_in_gi_b: ?f32,

    /// The number of vCPU to allocate. If you specify a value only for vCPU,
    /// SageMaker AI automatically allocates ratio-based values for MemoryInGiB
    /// based on this vCPU parameter. For example, if you allocate 20 out of 40
    /// total vCPU, SageMaker AI uses the ratio of 0.5 and allocates values to
    /// MemoryInGiB. Accelerators are set to 0.
    v_cpu: ?f32,

    pub const json_field_names = .{
        .accelerator_partition = "AcceleratorPartition",
        .accelerators = "Accelerators",
        .count = "Count",
        .instance_type = "InstanceType",
        .memory_in_gi_b = "MemoryInGiB",
        .v_cpu = "VCpu",
    };
};
