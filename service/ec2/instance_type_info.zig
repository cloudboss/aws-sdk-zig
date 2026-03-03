const EbsInfo = @import("ebs_info.zig").EbsInfo;
const FpgaInfo = @import("fpga_info.zig").FpgaInfo;
const GpuInfo = @import("gpu_info.zig").GpuInfo;
const InstanceTypeHypervisor = @import("instance_type_hypervisor.zig").InstanceTypeHypervisor;
const InferenceAcceleratorInfo = @import("inference_accelerator_info.zig").InferenceAcceleratorInfo;
const InstanceStorageInfo = @import("instance_storage_info.zig").InstanceStorageInfo;
const InstanceType = @import("instance_type.zig").InstanceType;
const MediaAcceleratorInfo = @import("media_accelerator_info.zig").MediaAcceleratorInfo;
const MemoryInfo = @import("memory_info.zig").MemoryInfo;
const NetworkInfo = @import("network_info.zig").NetworkInfo;
const NeuronInfo = @import("neuron_info.zig").NeuronInfo;
const NitroEnclavesSupport = @import("nitro_enclaves_support.zig").NitroEnclavesSupport;
const NitroTpmInfo = @import("nitro_tpm_info.zig").NitroTpmInfo;
const NitroTpmSupport = @import("nitro_tpm_support.zig").NitroTpmSupport;
const PhcSupport = @import("phc_support.zig").PhcSupport;
const PlacementGroupInfo = @import("placement_group_info.zig").PlacementGroupInfo;
const ProcessorInfo = @import("processor_info.zig").ProcessorInfo;
const RebootMigrationSupport = @import("reboot_migration_support.zig").RebootMigrationSupport;
const BootModeType = @import("boot_mode_type.zig").BootModeType;
const RootDeviceType = @import("root_device_type.zig").RootDeviceType;
const UsageClassType = @import("usage_class_type.zig").UsageClassType;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;
const VCpuInfo = @import("v_cpu_info.zig").VCpuInfo;

/// Describes the instance type.
pub const InstanceTypeInfo = struct {
    /// Indicates whether Amazon CloudWatch action based recovery is supported.
    auto_recovery_supported: ?bool = null,

    /// Indicates whether the instance is a bare metal instance type.
    bare_metal: ?bool = null,

    /// Indicates whether the instance type is a burstable performance T instance
    /// type. For more
    /// information, see [Burstable performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html).
    burstable_performance_supported: ?bool = null,

    /// Indicates whether the instance type is current generation.
    current_generation: ?bool = null,

    /// Indicates whether Dedicated Hosts are supported on the instance type.
    dedicated_hosts_supported: ?bool = null,

    /// Describes the Amazon EBS settings for the instance type.
    ebs_info: ?EbsInfo = null,

    /// Describes the FPGA accelerator settings for the instance type.
    fpga_info: ?FpgaInfo = null,

    /// Indicates whether the instance type is eligible for the free tier.
    free_tier_eligible: ?bool = null,

    /// Describes the GPU accelerator settings for the instance type.
    gpu_info: ?GpuInfo = null,

    /// Indicates whether On-Demand hibernation is supported.
    hibernation_supported: ?bool = null,

    /// The hypervisor for the instance type.
    hypervisor: ?InstanceTypeHypervisor = null,

    /// Describes the Inference accelerator settings for the instance type.
    inference_accelerator_info: ?InferenceAcceleratorInfo = null,

    /// Describes the instance storage for the instance type.
    instance_storage_info: ?InstanceStorageInfo = null,

    /// Indicates whether instance storage is supported.
    instance_storage_supported: ?bool = null,

    /// The instance type. For more information, see [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2
    /// User Guide*.
    instance_type: ?InstanceType = null,

    /// Describes the media accelerator settings for the instance type.
    media_accelerator_info: ?MediaAcceleratorInfo = null,

    /// Describes the memory for the instance type.
    memory_info: ?MemoryInfo = null,

    /// Describes the network settings for the instance type.
    network_info: ?NetworkInfo = null,

    /// Describes the Neuron accelerator settings for the instance type.
    neuron_info: ?NeuronInfo = null,

    /// Indicates whether Nitro Enclaves is supported.
    nitro_enclaves_support: ?NitroEnclavesSupport = null,

    /// Describes the supported NitroTPM versions for the instance type.
    nitro_tpm_info: ?NitroTpmInfo = null,

    /// Indicates whether NitroTPM is supported.
    nitro_tpm_support: ?NitroTpmSupport = null,

    /// Indicates whether a local Precision Time Protocol (PTP) hardware clock (PHC)
    /// is
    /// supported.
    phc_support: ?PhcSupport = null,

    /// Describes the placement group settings for the instance type.
    placement_group_info: ?PlacementGroupInfo = null,

    /// Describes the processor.
    processor_info: ?ProcessorInfo = null,

    /// Indicates whether reboot migration during a user-initiated reboot is
    /// supported for
    /// instances that have a scheduled `system-reboot` event. For more information,
    /// see [Enable or disable reboot
    /// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration) in the
    /// *Amazon EC2 User Guide*.
    reboot_migration_support: ?RebootMigrationSupport = null,

    /// The supported boot modes. For more information, see [Boot
    /// modes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html) in
    /// the *Amazon EC2 User
    /// Guide*.
    supported_boot_modes: ?[]const BootModeType = null,

    /// The supported root device types.
    supported_root_device_types: ?[]const RootDeviceType = null,

    /// Indicates whether the instance type is offered for spot, On-Demand, or
    /// Capacity
    /// Blocks.
    supported_usage_classes: ?[]const UsageClassType = null,

    /// The supported virtualization types.
    supported_virtualization_types: ?[]const VirtualizationType = null,

    /// Describes the vCPU configurations for the instance type.
    v_cpu_info: ?VCpuInfo = null,
};
