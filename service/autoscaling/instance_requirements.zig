const AcceleratorCountRequest = @import("accelerator_count_request.zig").AcceleratorCountRequest;
const AcceleratorManufacturer = @import("accelerator_manufacturer.zig").AcceleratorManufacturer;
const AcceleratorName = @import("accelerator_name.zig").AcceleratorName;
const AcceleratorTotalMemoryMiBRequest = @import("accelerator_total_memory_mi_b_request.zig").AcceleratorTotalMemoryMiBRequest;
const AcceleratorType = @import("accelerator_type.zig").AcceleratorType;
const BareMetal = @import("bare_metal.zig").BareMetal;
const BaselineEbsBandwidthMbpsRequest = @import("baseline_ebs_bandwidth_mbps_request.zig").BaselineEbsBandwidthMbpsRequest;
const BaselinePerformanceFactorsRequest = @import("baseline_performance_factors_request.zig").BaselinePerformanceFactorsRequest;
const BurstablePerformance = @import("burstable_performance.zig").BurstablePerformance;
const CpuManufacturer = @import("cpu_manufacturer.zig").CpuManufacturer;
const InstanceGeneration = @import("instance_generation.zig").InstanceGeneration;
const LocalStorage = @import("local_storage.zig").LocalStorage;
const LocalStorageType = @import("local_storage_type.zig").LocalStorageType;
const MemoryGiBPerVCpuRequest = @import("memory_gi_b_per_v_cpu_request.zig").MemoryGiBPerVCpuRequest;
const MemoryMiBRequest = @import("memory_mi_b_request.zig").MemoryMiBRequest;
const NetworkBandwidthGbpsRequest = @import("network_bandwidth_gbps_request.zig").NetworkBandwidthGbpsRequest;
const NetworkInterfaceCountRequest = @import("network_interface_count_request.zig").NetworkInterfaceCountRequest;
const TotalLocalStorageGBRequest = @import("total_local_storage_gb_request.zig").TotalLocalStorageGBRequest;
const VCpuCountRequest = @import("v_cpu_count_request.zig").VCpuCountRequest;

/// The attributes for the instance types for a mixed instances policy. Amazon
/// EC2 Auto Scaling uses your
/// specified requirements to identify instance types. Then, it uses your
/// On-Demand and Spot
/// allocation strategies to launch instances from these instance types.
///
/// When you specify multiple attributes, you get instance types that satisfy
/// all of the
/// specified attributes. If you specify multiple values for an attribute, you
/// get instance
/// types that satisfy any of the specified values.
///
/// To limit the list of instance types from which Amazon EC2 Auto Scaling can
/// identify matching instance
/// types, you can use one of the following parameters, but not both in the same
/// request:
///
/// * `AllowedInstanceTypes` - The instance types to include in the list.
/// All other instance types are ignored, even if they match your specified
/// attributes.
///
/// * `ExcludedInstanceTypes` - The instance types to exclude from the
/// list, even if they match your specified attributes.
///
/// You must specify `VCpuCount` and `MemoryMiB`. All other
/// attributes are optional. Any unspecified optional attribute is set to its
/// default.
///
/// For more information, see [Create a mixed instances group using
/// attribute-based instance type
/// selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-mixed-instances-group-attribute-based-instance-type-selection.html) in the *Amazon EC2 Auto Scaling User Guide*. For help determining
/// which instance types match your attributes before you apply them to your
/// Auto Scaling group, see
/// [Preview instance types with specified
/// attributes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html#ec2fleet-get-instance-types-from-instance-requirements) in the
/// *Amazon EC2 User Guide*.
pub const InstanceRequirements = struct {
    /// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
    /// Services Inferentia
    /// chips) for an instance type.
    ///
    /// To exclude accelerator-enabled instance types, set `Max` to
    /// `0`.
    ///
    /// Default: No minimum or maximum limits
    accelerator_count: ?AcceleratorCountRequest,

    /// Indicates whether instance types must have accelerators by specific
    /// manufacturers.
    ///
    /// * For instance types with NVIDIA devices, specify `nvidia`.
    ///
    /// * For instance types with AMD devices, specify `amd`.
    ///
    /// * For instance types with Amazon Web Services devices, specify
    /// `amazon-web-services`.
    ///
    /// * For instance types with Xilinx devices, specify `xilinx`.
    ///
    /// Default: Any manufacturer
    accelerator_manufacturers: ?[]const AcceleratorManufacturer,

    /// Lists the accelerators that must be on an instance type.
    ///
    /// * For instance types with NVIDIA A100 GPUs, specify `a100`.
    ///
    /// * For instance types with NVIDIA V100 GPUs, specify `v100`.
    ///
    /// * For instance types with NVIDIA K80 GPUs, specify `k80`.
    ///
    /// * For instance types with NVIDIA T4 GPUs, specify `t4`.
    ///
    /// * For instance types with NVIDIA M60 GPUs, specify `m60`.
    ///
    /// * For instance types with AMD Radeon Pro V520 GPUs, specify
    /// `radeon-pro-v520`.
    ///
    /// * For instance types with Xilinx VU9P FPGAs, specify `vu9p`.
    ///
    /// Default: Any accelerator
    accelerator_names: ?[]const AcceleratorName,

    /// The minimum and maximum total memory size for the accelerators on an
    /// instance type, in
    /// MiB.
    ///
    /// Default: No minimum or maximum limits
    accelerator_total_memory_mi_b: ?AcceleratorTotalMemoryMiBRequest,

    /// Lists the accelerator types that must be on an instance type.
    ///
    /// * For instance types with GPU accelerators, specify `gpu`.
    ///
    /// * For instance types with FPGA accelerators, specify `fpga`.
    ///
    /// * For instance types with inference accelerators, specify
    /// `inference`.
    ///
    /// Default: Any accelerator type
    accelerator_types: ?[]const AcceleratorType,

    /// The instance types to apply your specified attributes against. All other
    /// instance
    /// types are ignored, even if they match your specified attributes.
    ///
    /// You can use strings with one or more wild cards, represented by an asterisk
    /// (`*`), to allow an instance type, size, or generation. The following are
    /// examples: `m5.8xlarge`, `c5*.*`, `m5a.*`,
    /// `r*`, `*3*`.
    ///
    /// For example, if you specify `c5*`, Amazon EC2 Auto Scaling will allow the
    /// entire C5
    /// instance family, which includes all C5a and C5n instance types. If you
    /// specify
    /// `m5a.*`, Amazon EC2 Auto Scaling will allow all the M5a instance types, but
    /// not the M5n
    /// instance types.
    ///
    /// If you specify `AllowedInstanceTypes`, you can't specify
    /// `ExcludedInstanceTypes`.
    ///
    /// Default: All instance types
    allowed_instance_types: ?[]const []const u8,

    /// Indicates whether bare metal instance types are included, excluded, or
    /// required.
    ///
    /// Default: `excluded`
    bare_metal: ?BareMetal,

    /// The minimum and maximum baseline bandwidth performance for an instance type,
    /// in Mbps.
    /// For more information, see [Amazon EBS–optimized
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// Default: No minimum or maximum limits
    baseline_ebs_bandwidth_mbps: ?BaselineEbsBandwidthMbpsRequest,

    /// The baseline performance factors for the instance requirements.
    baseline_performance_factors: ?BaselinePerformanceFactorsRequest,

    /// Indicates whether burstable performance instance types are included,
    /// excluded, or
    /// required. For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    ///
    /// Default: `excluded`
    burstable_performance: ?BurstablePerformance,

    /// Lists which specific CPU manufacturers to include.
    ///
    /// * For instance types with Intel CPUs, specify `intel`.
    ///
    /// * For instance types with AMD CPUs, specify `amd`.
    ///
    /// * For instance types with Amazon Web Services CPUs, specify
    /// `amazon-web-services`.
    ///
    /// * For instance types with Apple CPUs, specify
    /// `apple`.
    ///
    /// Don't confuse the CPU hardware manufacturer with the CPU hardware
    /// architecture.
    /// Instances will be launched with a compatible CPU architecture based on the
    /// Amazon
    /// Machine Image (AMI) that you specify in your launch template.
    ///
    /// Default: Any manufacturer
    cpu_manufacturers: ?[]const CpuManufacturer,

    /// The instance types to exclude. You can use strings with one or more wild
    /// cards,
    /// represented by an asterisk (`*`), to exclude an instance family, type, size,
    /// or generation. The following are examples: `m5.8xlarge`, `c5*.*`,
    /// `m5a.*`, `r*`, `*3*`.
    ///
    /// For example, if you specify `c5*`, you are excluding the entire C5 instance
    /// family, which includes all C5a and C5n instance types. If you specify
    /// `m5a.*`, Amazon EC2 Auto Scaling will exclude all the M5a instance types,
    /// but not the M5n
    /// instance types.
    ///
    /// If you specify `ExcludedInstanceTypes`, you can't specify
    /// `AllowedInstanceTypes`.
    ///
    /// Default: No excluded instance types
    excluded_instance_types: ?[]const []const u8,

    /// Indicates whether current or previous generation instance types are
    /// included.
    ///
    /// * For current generation instance types, specify `current`. The
    /// current generation includes EC2 instance types currently recommended for
    /// use.
    /// This typically includes the latest two to three generations in each instance
    /// family. For more information, see [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in
    /// the *Amazon EC2 User Guide*.
    ///
    /// * For previous generation instance types, specify `previous`.
    ///
    /// Default: Any current or previous generation
    instance_generations: ?[]const InstanceGeneration,

    /// Indicates whether instance types with instance store volumes are included,
    /// excluded,
    /// or required. For more information, see [Amazon EC2 instance
    /// store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) in
    /// the *Amazon EC2 User Guide*.
    ///
    /// Default: `included`
    local_storage: ?LocalStorage,

    /// Indicates the type of local storage that is required.
    ///
    /// * For instance types with hard disk drive (HDD) storage, specify
    /// `hdd`.
    ///
    /// * For instance types with solid state drive (SSD) storage, specify
    /// `ssd`.
    ///
    /// Default: Any local storage type
    local_storage_types: ?[]const LocalStorageType,

    /// [Price protection] The price protection threshold for Spot Instances, as a
    /// percentage
    /// of an identified On-Demand price. The identified On-Demand price is the
    /// price of the
    /// lowest priced current generation C, M, or R instance type with your
    /// specified
    /// attributes. If no current generation C, M, or R instance type matches your
    /// attributes,
    /// then the identified price is from either the lowest priced current
    /// generation instance
    /// types or, failing that, the lowest priced previous generation instance types
    /// that match
    /// your attributes. When Amazon EC2 Auto Scaling selects instance types with
    /// your attributes, we will
    /// exclude instance types whose price exceeds your specified threshold.
    ///
    /// The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets
    /// as a percentage.
    ///
    /// If you set `DesiredCapacityType` to `vcpu` or
    /// `memory-mib`, the price protection threshold is based on the per-vCPU or
    /// per-memory price instead of the per instance price.
    ///
    /// Only one of `SpotMaxPricePercentageOverLowestPrice` or
    /// `MaxSpotPriceAsPercentageOfOptimalOnDemandPrice` can be specified. If
    /// you don't specify either, Amazon EC2 Auto Scaling will automatically apply
    /// optimal price protection
    /// to consistently select from a wide range of instance types. To indicate no
    /// price
    /// protection threshold for Spot Instances, meaning you want to consider all
    /// instance
    /// types that match your attributes, include one of these parameters and
    /// specify a high
    /// value, such as `999999`.
    max_spot_price_as_percentage_of_optimal_on_demand_price: ?i32,

    /// The minimum and maximum amount of memory per vCPU for an instance type, in
    /// GiB.
    ///
    /// Default: No minimum or maximum limits
    memory_gi_b_per_v_cpu: ?MemoryGiBPerVCpuRequest,

    /// The minimum and maximum instance memory size for an instance type, in MiB.
    memory_mi_b: MemoryMiBRequest,

    /// The minimum and maximum amount of network bandwidth, in gigabits per second
    /// (Gbps).
    ///
    /// Default: No minimum or maximum limits
    network_bandwidth_gbps: ?NetworkBandwidthGbpsRequest,

    /// The minimum and maximum number of network interfaces for an instance type.
    ///
    /// Default: No minimum or maximum limits
    network_interface_count: ?NetworkInterfaceCountRequest,

    /// [Price protection] The price protection threshold for On-Demand Instances,
    /// as a
    /// percentage higher than an identified On-Demand price. The identified
    /// On-Demand price is
    /// the price of the lowest priced current generation C, M, or R instance type
    /// with your
    /// specified attributes. If no current generation C, M, or R instance type
    /// matches your
    /// attributes, then the identified price is from either the lowest priced
    /// current
    /// generation instance types or, failing that, the lowest priced previous
    /// generation
    /// instance types that match your attributes. When Amazon EC2 Auto Scaling
    /// selects instance types with
    /// your attributes, we will exclude instance types whose price exceeds your
    /// specified
    /// threshold.
    ///
    /// The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets
    /// as a percentage.
    ///
    /// To turn off price protection, specify a high value, such as `999999`.
    ///
    /// If you set `DesiredCapacityType` to `vcpu` or
    /// `memory-mib`, the price protection threshold is applied based on the
    /// per-vCPU or per-memory price instead of the per instance price.
    ///
    /// Default: `20`
    on_demand_max_price_percentage_over_lowest_price: ?i32,

    /// Indicates whether instance types must provide On-Demand Instance hibernation
    /// support.
    ///
    /// Default: `false`
    require_hibernate_support: ?bool,

    /// [Price protection] The price protection threshold for Spot Instances, as a
    /// percentage
    /// higher than an identified Spot price. The identified Spot price is the price
    /// of the
    /// lowest priced current generation C, M, or R instance type with your
    /// specified
    /// attributes. If no current generation C, M, or R instance type matches your
    /// attributes,
    /// then the identified price is from either the lowest priced current
    /// generation instance
    /// types or, failing that, the lowest priced previous generation instance types
    /// that match
    /// your attributes. When Amazon EC2 Auto Scaling selects instance types with
    /// your attributes, we will
    /// exclude instance types whose price exceeds your specified threshold.
    ///
    /// The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets
    /// as a percentage.
    ///
    /// If you set `DesiredCapacityType` to `vcpu` or
    /// `memory-mib`, the price protection threshold is based on the per-vCPU or
    /// per-memory price instead of the per instance price.
    ///
    /// Only one of `SpotMaxPricePercentageOverLowestPrice` or
    /// `MaxSpotPriceAsPercentageOfOptimalOnDemandPrice` can be specified. If
    /// you don't specify either, Amazon EC2 Auto Scaling will automatically apply
    /// optimal price protection
    /// to consistently select from a wide range of instance types. To indicate no
    /// price
    /// protection threshold for Spot Instances, meaning you want to consider all
    /// instance
    /// types that match your attributes, include one of these parameters and
    /// specify a high
    /// value, such as `999999`.
    spot_max_price_percentage_over_lowest_price: ?i32,

    /// The minimum and maximum total local storage size for an instance type, in
    /// GB.
    ///
    /// Default: No minimum or maximum limits
    total_local_storage_gb: ?TotalLocalStorageGBRequest,

    /// The minimum and maximum number of vCPUs for an instance type.
    v_cpu_count: VCpuCountRequest,
};
