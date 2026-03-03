const AcceleratorCapabilities = @import("accelerator_capabilities.zig").AcceleratorCapabilities;
const CpuArchitectureType = @import("cpu_architecture_type.zig").CpuArchitectureType;
const FleetAmountCapability = @import("fleet_amount_capability.zig").FleetAmountCapability;
const FleetAttributeCapability = @import("fleet_attribute_capability.zig").FleetAttributeCapability;
const MemoryMiBRange = @import("memory_mi_b_range.zig").MemoryMiBRange;
const ServiceManagedFleetOperatingSystemFamily = @import("service_managed_fleet_operating_system_family.zig").ServiceManagedFleetOperatingSystemFamily;
const Ec2EbsVolume = @import("ec_2_ebs_volume.zig").Ec2EbsVolume;
const VCpuCountRange = @import("v_cpu_count_range.zig").VCpuCountRange;

/// The Amazon EC2 instance capabilities.
pub const ServiceManagedEc2InstanceCapabilities = struct {
    /// Describes the GPU accelerator capabilities required for worker host
    /// instances in this fleet.
    accelerator_capabilities: ?AcceleratorCapabilities = null,

    /// The allowable Amazon EC2 instance types.
    allowed_instance_types: ?[]const []const u8 = null,

    /// The CPU architecture type.
    cpu_architecture_type: CpuArchitectureType,

    /// The custom capability amounts to require for instances in this fleet.
    custom_amounts: ?[]const FleetAmountCapability = null,

    /// The custom capability attributes to require for instances in this fleet.
    custom_attributes: ?[]const FleetAttributeCapability = null,

    /// The instance types to exclude from the fleet.
    excluded_instance_types: ?[]const []const u8 = null,

    /// The memory, as MiB, for the Amazon EC2 instance type.
    memory_mi_b: MemoryMiBRange,

    /// The operating system (OS) family.
    os_family: ServiceManagedFleetOperatingSystemFamily,

    /// The root EBS volume.
    root_ebs_volume: ?Ec2EbsVolume = null,

    /// The amount of vCPU to require for instances in this fleet.
    v_cpu_count: VCpuCountRange,

    pub const json_field_names = .{
        .accelerator_capabilities = "acceleratorCapabilities",
        .allowed_instance_types = "allowedInstanceTypes",
        .cpu_architecture_type = "cpuArchitectureType",
        .custom_amounts = "customAmounts",
        .custom_attributes = "customAttributes",
        .excluded_instance_types = "excludedInstanceTypes",
        .memory_mi_b = "memoryMiB",
        .os_family = "osFamily",
        .root_ebs_volume = "rootEbsVolume",
        .v_cpu_count = "vCpuCount",
    };
};
