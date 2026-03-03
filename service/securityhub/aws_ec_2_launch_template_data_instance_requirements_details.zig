const AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorCountDetails = @import("aws_ec_2_launch_template_data_instance_requirements_accelerator_count_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorCountDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorTotalMemoryMiBDetails = @import("aws_ec_2_launch_template_data_instance_requirements_accelerator_total_memory_mi_b_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorTotalMemoryMiBDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsBaselineEbsBandwidthMbpsDetails = @import("aws_ec_2_launch_template_data_instance_requirements_baseline_ebs_bandwidth_mbps_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsBaselineEbsBandwidthMbpsDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsMemoryGiBPerVCpuDetails = @import("aws_ec_2_launch_template_data_instance_requirements_memory_gi_b_per_v_cpu_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsMemoryGiBPerVCpuDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsMemoryMiBDetails = @import("aws_ec_2_launch_template_data_instance_requirements_memory_mi_b_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsMemoryMiBDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsNetworkInterfaceCountDetails = @import("aws_ec_2_launch_template_data_instance_requirements_network_interface_count_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsNetworkInterfaceCountDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsTotalLocalStorageGBDetails = @import("aws_ec_2_launch_template_data_instance_requirements_total_local_storage_gb_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsTotalLocalStorageGBDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsVCpuCountDetails = @import("aws_ec_2_launch_template_data_instance_requirements_v_cpu_count_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsVCpuCountDetails;

/// The attributes for the Amazon EC2 instance types.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsDetails = struct {
    /// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
    /// Services Inferentia chips) on an instance.
    accelerator_count: ?AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorCountDetails = null,

    /// Indicates whether instance types must have accelerators by specific
    /// manufacturers.
    accelerator_manufacturers: ?[]const []const u8 = null,

    /// The accelerators that must be on the instance type.
    accelerator_names: ?[]const []const u8 = null,

    /// The minimum and maximum amount of total accelerator memory, in MiB.
    accelerator_total_memory_mi_b: ?AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorTotalMemoryMiBDetails = null,

    /// The accelerator types that must be on the instance type.
    accelerator_types: ?[]const []const u8 = null,

    /// Indicates whether bare metal instance types must be included, excluded, or
    /// required.
    bare_metal: ?[]const u8 = null,

    /// The minimum and maximum baseline bandwidth to Amazon EBS, in Mbps. For more
    /// information, see [Amazon EBS optimized
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the *Amazon EC2 User Guide*.
    baseline_ebs_bandwidth_mbps: ?AwsEc2LaunchTemplateDataInstanceRequirementsBaselineEbsBandwidthMbpsDetails = null,

    /// Indicates whether burstable performance T instance types are included,
    /// excluded, or required. For more information, [Burstable performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    burstable_performance: ?[]const u8 = null,

    /// The CPU manufacturers to include.
    cpu_manufacturers: ?[]const []const u8 = null,

    /// The instance types to exclude.
    excluded_instance_types: ?[]const []const u8 = null,

    /// Indicates whether current or previous generation instance types are
    /// included.
    instance_generations: ?[]const []const u8 = null,

    /// Indicates whether instance types with instance store volumes are included,
    /// excluded, or required. For more information, see [Amazon EC2 instance
    /// store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) in the *Amazon EC2 User Guide*.
    local_storage: ?[]const u8 = null,

    /// The type of local storage that is required.
    local_storage_types: ?[]const []const u8 = null,

    /// The minimum and maximum amount of memory per vCPU, in GiB.
    memory_gi_b_per_v_cpu: ?AwsEc2LaunchTemplateDataInstanceRequirementsMemoryGiBPerVCpuDetails = null,

    /// The minimum and maximum amount of memory, in MiB.
    memory_mi_b: ?AwsEc2LaunchTemplateDataInstanceRequirementsMemoryMiBDetails = null,

    /// The minimum and maximum number of network interfaces.
    network_interface_count: ?AwsEc2LaunchTemplateDataInstanceRequirementsNetworkInterfaceCountDetails = null,

    /// The price protection threshold for On-Demand Instances. This is the maximum
    /// you'll pay
    /// for an On-Demand Instance, expressed as a percentage above the least
    /// expensive current
    /// generation M, C, or R instance type with your specified attributes. When
    /// Amazon EC2 selects
    /// instance types with your attributes, it excludes instance types priced above
    /// your
    /// threshold.
    ///
    /// The parameter accepts an integer, which Amazon EC2 interprets as a
    /// percentage.
    ///
    /// A high value, such as `999999`, turns off price protection.
    on_demand_max_price_percentage_over_lowest_price: ?i32 = null,

    /// Indicates whether instance types must support hibernation for On-Demand
    /// Instances.
    require_hibernate_support: ?bool = null,

    /// The price protection threshold for Spot Instances. This is the maximum
    /// you'll pay for a
    /// Spot Instance, expressed as a percentage above the least expensive current
    /// generation M, C,
    /// or R instance type with your specified attributes. When Amazon EC2 selects
    /// instance
    /// types with your attributes, it excludes instance types priced above your
    /// threshold.
    ///
    /// The parameter accepts an integer, which Amazon EC2 interprets as a
    /// percentage.
    ///
    /// A high value, such as `999999`, turns off price protection.
    spot_max_price_percentage_over_lowest_price: ?i32 = null,

    /// The minimum and maximum amount of total local storage, in GB.
    total_local_storage_gb: ?AwsEc2LaunchTemplateDataInstanceRequirementsTotalLocalStorageGBDetails = null,

    /// The minimum and maximum number of vCPUs.
    v_cpu_count: ?AwsEc2LaunchTemplateDataInstanceRequirementsVCpuCountDetails = null,

    pub const json_field_names = .{
        .accelerator_count = "AcceleratorCount",
        .accelerator_manufacturers = "AcceleratorManufacturers",
        .accelerator_names = "AcceleratorNames",
        .accelerator_total_memory_mi_b = "AcceleratorTotalMemoryMiB",
        .accelerator_types = "AcceleratorTypes",
        .bare_metal = "BareMetal",
        .baseline_ebs_bandwidth_mbps = "BaselineEbsBandwidthMbps",
        .burstable_performance = "BurstablePerformance",
        .cpu_manufacturers = "CpuManufacturers",
        .excluded_instance_types = "ExcludedInstanceTypes",
        .instance_generations = "InstanceGenerations",
        .local_storage = "LocalStorage",
        .local_storage_types = "LocalStorageTypes",
        .memory_gi_b_per_v_cpu = "MemoryGiBPerVCpu",
        .memory_mi_b = "MemoryMiB",
        .network_interface_count = "NetworkInterfaceCount",
        .on_demand_max_price_percentage_over_lowest_price = "OnDemandMaxPricePercentageOverLowestPrice",
        .require_hibernate_support = "RequireHibernateSupport",
        .spot_max_price_percentage_over_lowest_price = "SpotMaxPricePercentageOverLowestPrice",
        .total_local_storage_gb = "TotalLocalStorageGB",
        .v_cpu_count = "VCpuCount",
    };
};
