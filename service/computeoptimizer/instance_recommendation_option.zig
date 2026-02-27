const GpuInfo = @import("gpu_info.zig").GpuInfo;
const MigrationEffort = @import("migration_effort.zig").MigrationEffort;
const PlatformDifference = @import("platform_difference.zig").PlatformDifference;
const UtilizationMetric = @import("utilization_metric.zig").UtilizationMetric;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const InstanceSavingsOpportunityAfterDiscounts = @import("instance_savings_opportunity_after_discounts.zig").InstanceSavingsOpportunityAfterDiscounts;

/// Describes a recommendation option for an Amazon EC2 instance.
pub const InstanceRecommendationOption = struct {
    /// Describes the GPU accelerator settings for the recommended instance type.
    instance_gpu_info: ?GpuInfo,

    /// The instance type of the instance recommendation.
    instance_type: ?[]const u8,

    /// The level of effort required to migrate from the current instance type to
    /// the
    /// recommended instance type.
    ///
    /// For example, the migration effort is `Low` if Amazon EMR is the
    /// inferred workload type and an Amazon Web Services Graviton instance type is
    /// recommended.
    /// The migration effort is `Medium` if a workload type couldn't be inferred but
    /// an Amazon Web Services Graviton instance type is recommended. The migration
    /// effort is
    /// `VeryLow` if both the current and recommended instance types are of the
    /// same CPU architecture.
    migration_effort: ?MigrationEffort,

    /// The performance risk of the instance recommendation option.
    ///
    /// Performance risk indicates the likelihood of the recommended instance type
    /// not meeting
    /// the resource needs of your workload. Compute Optimizer calculates an
    /// individual
    /// performance risk score for each specification of the recommended instance,
    /// including
    /// CPU, memory, EBS throughput, EBS IOPS, disk throughput, disk IOPS, network
    /// throughput,
    /// and network PPS.
    /// The performance
    /// risk of the recommended instance is calculated as the maximum performance
    /// risk score
    /// across the analyzed resource specifications.
    ///
    /// The value ranges from `0` - `4`, with `0` meaning
    /// that the recommended resource is predicted to always provide enough hardware
    /// capability.
    /// The higher the performance risk is, the more likely you should validate
    /// whether the
    /// recommendation will meet the performance requirements of your workload
    /// before migrating
    /// your resource.
    performance_risk: f64 = 0,

    /// Describes the configuration differences between the current instance and the
    /// recommended instance type. You should consider the configuration differences
    /// before
    /// migrating your workloads from the current instance to the recommended
    /// instance type. The
    /// [Change the instance type guide for
    /// Linux](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-resize.html) and [Change the instance type
    /// guide for
    /// Windows](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-resize.html) provide general guidance for getting started with an
    /// instance migration.
    ///
    /// Platform differences include:
    ///
    /// * **
    /// `Hypervisor`
    /// ** — The hypervisor of
    /// the recommended instance type is different than that of the current
    /// instance.
    /// For example, the recommended instance type uses a Nitro hypervisor and the
    /// current instance uses a Xen hypervisor. The differences that you should
    /// consider
    /// between these hypervisors are covered in the [Nitro
    /// Hypervisor](http://aws.amazon.com/ec2/faqs/#Nitro_Hypervisor) section of the
    /// Amazon EC2 frequently asked questions. For more information, see
    /// [Instances built on the Nitro
    /// System](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances) in the *Amazon EC2
    /// User Guide for Linux*, or [Instances built on the Nitro
    /// System](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instance-types.html#ec2-nitro-instances) in the *Amazon EC2
    /// User Guide for Windows*.
    ///
    /// * **
    /// `NetworkInterface`
    /// ** — The network
    /// interface of the recommended instance type is different than that of the
    /// current
    /// instance. For example, the recommended instance type supports enhanced
    /// networking and the current instance might not. To enable enhanced networking
    /// for
    /// the recommended instance type, you must install the Elastic Network Adapter
    /// (ENA) driver or the Intel 82599 Virtual Function driver. For more
    /// information,
    /// see [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#instance-networking-storage) and [Enhanced networking
    /// on
    /// Linux](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html) in the *Amazon EC2 User Guide for
    /// Linux*, or [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instance-types.html#instance-networking-storage) and [Enhanced
    /// networking on
    /// Windows](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/enhanced-networking.html) in the *Amazon EC2 User Guide for
    /// Windows*.
    ///
    /// * **
    /// `StorageInterface`
    /// ** — The storage
    /// interface of the recommended instance type is different than that of the
    /// current
    /// instance. For example, the recommended instance type uses an NVMe storage
    /// interface and the current instance does not. To access NVMe volumes for the
    /// recommended instance type, you will need to install or upgrade the NVMe
    /// driver.
    /// For more information, see [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#instance-networking-storage) and [Amazon EBS and NVMe on
    /// Linux
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nvme-ebs-volumes.html) in the *Amazon EC2 User Guide for
    /// Linux*, or [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instance-types.html#instance-networking-storage) and [Amazon EBS and NVMe
    /// on Windows
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/nvme-ebs-volumes.html) in the *Amazon EC2 User Guide for
    /// Windows*.
    ///
    /// * **
    /// `InstanceStoreAvailability`
    /// ** — The
    /// recommended instance type does not support instance store volumes and the
    /// current instance does. Before migrating, you might need to back up the data
    /// on
    /// your instance store volumes if you want to preserve them. For more
    /// information,
    /// see [How do I back up an instance store volume on my Amazon EC2 instance
    /// to Amazon
    /// EBS?](https://aws.amazon.com/premiumsupport/knowledge-center/back-up-instance-store-ebs/) in the *Amazon Web Services Premium
    /// Support Knowledge Base*. For more information, see [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#instance-networking-storage) and [Amazon EC2
    /// instance
    /// store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) in the *Amazon EC2 User Guide for
    /// Linux*, or see [Networking and storage
    /// features](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instance-types.html#instance-networking-storage) and [Amazon EC2
    /// instance
    /// store](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/InstanceStorage.html) in the *Amazon EC2 User Guide for
    /// Windows*.
    ///
    /// * **
    /// `VirtualizationType`
    /// ** — The
    /// recommended instance type uses the hardware virtual machine (HVM)
    /// virtualization
    /// type and the current instance uses the paravirtual (PV) virtualization type.
    /// For
    /// more information about the differences between these virtualization types,
    /// see
    /// [Linux AMI
    /// virtualization
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/virtualization_types.html) in the *Amazon EC2 User Guide for
    /// Linux*, or [Windows AMI virtualization
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/windows-ami-version-history.html#virtualization-types) in the *Amazon EC2 User
    /// Guide for Windows*.
    ///
    /// * **
    /// `Architecture`
    /// ** — The CPU
    /// architecture between the recommended instance type and the current instance
    /// is
    /// different. For example, the recommended instance type might use an Arm CPU
    /// architecture and the current instance type might use a different one, such
    /// as
    /// x86. Before migrating, you should consider recompiling the software on your
    /// instance for the new architecture. Alternatively, you might switch to an
    /// Amazon
    /// Machine Image (AMI) that supports the new architecture. For more information
    /// about the CPU architecture for each instance type, see [Amazon EC2 Instance
    /// Types](http://aws.amazon.com/ec2/instance-types/).
    platform_differences: ?[]const PlatformDifference,

    /// An array of objects that describe the projected utilization metrics of the
    /// instance
    /// recommendation option.
    ///
    /// The `Cpu` and `Memory` metrics are the only projected
    /// utilization metrics returned. Additionally, the `Memory` metric is
    /// returned only for resources that have the unified CloudWatch agent installed
    /// on them. For more information, see [Enabling Memory
    /// Utilization with the CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent).
    projected_utilization_metrics: ?[]const UtilizationMetric,

    /// The rank of the instance recommendation option.
    ///
    /// The top recommendation option is ranked as `1`.
    rank: i32 = 0,

    /// An object that describes the savings opportunity for the instance
    /// recommendation
    /// option. Savings opportunity includes the estimated monthly savings amount
    /// and
    /// percentage.
    savings_opportunity: ?SavingsOpportunity,

    /// An object that describes the savings opportunity for the instance
    /// recommendation option that includes Savings Plans and Reserved Instances
    /// discounts. Savings opportunity includes the estimated monthly savings and
    /// percentage.
    savings_opportunity_after_discounts: ?InstanceSavingsOpportunityAfterDiscounts,

    pub const json_field_names = .{
        .instance_gpu_info = "instanceGpuInfo",
        .instance_type = "instanceType",
        .migration_effort = "migrationEffort",
        .performance_risk = "performanceRisk",
        .platform_differences = "platformDifferences",
        .projected_utilization_metrics = "projectedUtilizationMetrics",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
