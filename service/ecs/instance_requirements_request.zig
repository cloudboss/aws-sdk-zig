const AcceleratorCountRequest = @import("accelerator_count_request.zig").AcceleratorCountRequest;
const AcceleratorManufacturer = @import("accelerator_manufacturer.zig").AcceleratorManufacturer;
const AcceleratorName = @import("accelerator_name.zig").AcceleratorName;
const AcceleratorTotalMemoryMiBRequest = @import("accelerator_total_memory_mi_b_request.zig").AcceleratorTotalMemoryMiBRequest;
const AcceleratorType = @import("accelerator_type.zig").AcceleratorType;
const BareMetal = @import("bare_metal.zig").BareMetal;
const BaselineEbsBandwidthMbpsRequest = @import("baseline_ebs_bandwidth_mbps_request.zig").BaselineEbsBandwidthMbpsRequest;
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
const VCpuCountRangeRequest = @import("v_cpu_count_range_request.zig").VCpuCountRangeRequest;

/// The instance requirements for attribute-based instance type selection.
/// Instead of
/// specifying exact instance types, you define requirements such as vCPU count,
/// memory
/// size, network performance, and accelerator specifications. Amazon ECS
/// automatically
/// selects Amazon EC2 instance types that match these requirements, providing
/// flexibility
/// and helping to mitigate capacity constraints.
pub const InstanceRequirementsRequest = struct {
    /// The minimum and maximum number of accelerators for the instance types. This
    /// is used
    /// when you need instances with specific numbers of GPUs or other accelerators.
    accelerator_count: ?AcceleratorCountRequest = null,

    /// The accelerator manufacturers to include. You can specify `nvidia`,
    /// `amd`, `amazon-web-services`, or `xilinx` depending
    /// on your accelerator requirements.
    accelerator_manufacturers: ?[]const AcceleratorManufacturer = null,

    /// The specific accelerator names to include. For example, you can specify
    /// `a100`, `v100`, `k80`, or other specific
    /// accelerator models.
    accelerator_names: ?[]const AcceleratorName = null,

    /// The minimum and maximum total accelerator memory in mebibytes (MiB). This is
    /// important
    /// for GPU workloads that require specific amounts of video memory.
    accelerator_total_memory_mi_b: ?AcceleratorTotalMemoryMiBRequest = null,

    /// The accelerator types to include. You can specify `gpu` for graphics
    /// processing units, `fpga` for field programmable gate arrays, or
    /// `inference` for machine learning inference accelerators.
    accelerator_types: ?[]const AcceleratorType = null,

    /// The instance types to include in the selection. When specified, Amazon ECS
    /// only
    /// considers these instance types, subject to the other requirements specified.
    allowed_instance_types: ?[]const []const u8 = null,

    /// Indicates whether to include bare metal instance types. Set to `included`
    /// to allow bare metal instances, `excluded` to exclude them, or
    /// `required` to use only bare metal instances.
    bare_metal: ?BareMetal = null,

    /// The minimum and maximum baseline Amazon EBS bandwidth in megabits per second
    /// (Mbps).
    /// This is important for workloads with high storage I/O requirements.
    baseline_ebs_bandwidth_mbps: ?BaselineEbsBandwidthMbpsRequest = null,

    /// Indicates whether to include burstable performance instance types (T2, T3,
    /// T3a, T4g).
    /// Set to `included` to allow burstable instances, `excluded` to
    /// exclude them, or `required` to use only burstable instances.
    burstable_performance: ?BurstablePerformance = null,

    /// The CPU manufacturers to include or exclude. You can specify `intel`,
    /// `amd`, or `amazon-web-services` to control which CPU types are
    /// used for your workloads.
    cpu_manufacturers: ?[]const CpuManufacturer = null,

    /// The instance types to exclude from selection. Use this to prevent Amazon ECS
    /// from
    /// selecting specific instance types that may not be suitable for your
    /// workloads.
    excluded_instance_types: ?[]const []const u8 = null,

    /// The instance generations to include. You can specify `current` to use the
    /// latest generation instances, or `previous` to include previous generation
    /// instances for cost optimization.
    instance_generations: ?[]const InstanceGeneration = null,

    /// Indicates whether to include instance types with local storage. Set to
    /// `included` to allow local storage, `excluded` to exclude it,
    /// or `required` to use only instances with local storage.
    local_storage: ?LocalStorage = null,

    /// The local storage types to include. You can specify `hdd` for hard disk
    /// drives, `ssd` for solid state drives, or both.
    local_storage_types: ?[]const LocalStorageType = null,

    /// The maximum price for Spot instances as a percentage of the optimal
    /// On-Demand price.
    /// This provides more precise cost control for Spot instance selection.
    max_spot_price_as_percentage_of_optimal_on_demand_price: ?i32 = null,

    /// The minimum and maximum amount of memory per vCPU in gibibytes (GiB). This
    /// helps
    /// ensure that instance types have the appropriate memory-to-CPU ratio for your
    /// workloads.
    memory_gi_b_per_v_cpu: ?MemoryGiBPerVCpuRequest = null,

    /// The minimum and maximum amount of memory in mebibytes (MiB) for the instance
    /// types.
    /// Amazon ECS selects instance types that have memory within this range.
    memory_mi_b: MemoryMiBRequest,

    /// The minimum and maximum network bandwidth in gigabits per second (Gbps).
    /// This is
    /// crucial for network-intensive workloads that require high throughput.
    network_bandwidth_gbps: ?NetworkBandwidthGbpsRequest = null,

    /// The minimum and maximum number of network interfaces for the instance types.
    /// This is
    /// useful for workloads that require multiple network interfaces.
    network_interface_count: ?NetworkInterfaceCountRequest = null,

    /// The price protection threshold for On-Demand Instances, as a percentage
    /// higher than an
    /// identified On-Demand price. The identified On-Demand price is the price of
    /// the lowest
    /// priced current generation C, M, or R instance type with your specified
    /// attributes. If no
    /// current generation C, M, or R instance type matches your attributes, then
    /// the identified
    /// price is from either the lowest priced current generation instance types or,
    /// failing
    /// that, the lowest priced previous generation instance types that match your
    /// attributes.
    /// When Amazon ECS selects instance types with your attributes, we will exclude
    /// instance
    /// types whose price exceeds your specified threshold.
    on_demand_max_price_percentage_over_lowest_price: ?i32 = null,

    /// Indicates whether the instance types must support hibernation. When set to
    /// `true`, only instance types that support hibernation are selected.
    require_hibernate_support: ?bool = null,

    /// The maximum price for Spot instances as a percentage over the lowest priced
    /// On-Demand
    /// instance. This helps control Spot instance costs while maintaining access to
    /// capacity.
    spot_max_price_percentage_over_lowest_price: ?i32 = null,

    /// The minimum and maximum total local storage in gigabytes (GB) for instance
    /// types with
    /// local storage.
    total_local_storage_gb: ?TotalLocalStorageGBRequest = null,

    /// The minimum and maximum number of vCPUs for the instance types. Amazon ECS
    /// selects
    /// instance types that have vCPU counts within this range.
    v_cpu_count: VCpuCountRangeRequest,

    pub const json_field_names = .{
        .accelerator_count = "acceleratorCount",
        .accelerator_manufacturers = "acceleratorManufacturers",
        .accelerator_names = "acceleratorNames",
        .accelerator_total_memory_mi_b = "acceleratorTotalMemoryMiB",
        .accelerator_types = "acceleratorTypes",
        .allowed_instance_types = "allowedInstanceTypes",
        .bare_metal = "bareMetal",
        .baseline_ebs_bandwidth_mbps = "baselineEbsBandwidthMbps",
        .burstable_performance = "burstablePerformance",
        .cpu_manufacturers = "cpuManufacturers",
        .excluded_instance_types = "excludedInstanceTypes",
        .instance_generations = "instanceGenerations",
        .local_storage = "localStorage",
        .local_storage_types = "localStorageTypes",
        .max_spot_price_as_percentage_of_optimal_on_demand_price = "maxSpotPriceAsPercentageOfOptimalOnDemandPrice",
        .memory_gi_b_per_v_cpu = "memoryGiBPerVCpu",
        .memory_mi_b = "memoryMiB",
        .network_bandwidth_gbps = "networkBandwidthGbps",
        .network_interface_count = "networkInterfaceCount",
        .on_demand_max_price_percentage_over_lowest_price = "onDemandMaxPricePercentageOverLowestPrice",
        .require_hibernate_support = "requireHibernateSupport",
        .spot_max_price_percentage_over_lowest_price = "spotMaxPricePercentageOverLowestPrice",
        .total_local_storage_gb = "totalLocalStorageGB",
        .v_cpu_count = "vCpuCount",
    };
};
