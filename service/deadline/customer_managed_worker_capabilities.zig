const AcceleratorCountRange = @import("accelerator_count_range.zig").AcceleratorCountRange;
const AcceleratorTotalMemoryMiBRange = @import("accelerator_total_memory_mi_b_range.zig").AcceleratorTotalMemoryMiBRange;
const AcceleratorType = @import("accelerator_type.zig").AcceleratorType;
const CpuArchitectureType = @import("cpu_architecture_type.zig").CpuArchitectureType;
const FleetAmountCapability = @import("fleet_amount_capability.zig").FleetAmountCapability;
const FleetAttributeCapability = @import("fleet_attribute_capability.zig").FleetAttributeCapability;
const MemoryMiBRange = @import("memory_mi_b_range.zig").MemoryMiBRange;
const CustomerManagedFleetOperatingSystemFamily = @import("customer_managed_fleet_operating_system_family.zig").CustomerManagedFleetOperatingSystemFamily;
const VCpuCountRange = @import("v_cpu_count_range.zig").VCpuCountRange;

/// The worker capabilities for a customer managed workflow.
pub const CustomerManagedWorkerCapabilities = struct {
    /// The range of the accelerator.
    accelerator_count: ?AcceleratorCountRange = null,

    /// The total memory (MiB) for the customer managed worker capabilities.
    accelerator_total_memory_mi_b: ?AcceleratorTotalMemoryMiBRange = null,

    /// The accelerator types for the customer managed worker capabilities.
    accelerator_types: ?[]const AcceleratorType = null,

    /// The CPU architecture type for the customer managed worker capabilities.
    cpu_architecture_type: CpuArchitectureType,

    /// Custom requirement ranges for customer managed worker capabilities.
    custom_amounts: ?[]const FleetAmountCapability = null,

    /// Custom attributes for the customer manged worker capabilities.
    custom_attributes: ?[]const FleetAttributeCapability = null,

    /// The memory (MiB).
    memory_mi_b: MemoryMiBRange,

    /// The operating system (OS) family.
    os_family: CustomerManagedFleetOperatingSystemFamily,

    /// The vCPU count for the customer manged worker capabilities.
    v_cpu_count: VCpuCountRange,

    pub const json_field_names = .{
        .accelerator_count = "acceleratorCount",
        .accelerator_total_memory_mi_b = "acceleratorTotalMemoryMiB",
        .accelerator_types = "acceleratorTypes",
        .cpu_architecture_type = "cpuArchitectureType",
        .custom_amounts = "customAmounts",
        .custom_attributes = "customAttributes",
        .memory_mi_b = "memoryMiB",
        .os_family = "osFamily",
        .v_cpu_count = "vCpuCount",
    };
};
