const ArchitectureValues = @import("architecture_values.zig").ArchitectureValues;
const InstanceBlockDeviceMapping = @import("instance_block_device_mapping.zig").InstanceBlockDeviceMapping;
const BootModeValues = @import("boot_mode_values.zig").BootModeValues;
const CapacityReservationSpecificationResponse = @import("capacity_reservation_specification_response.zig").CapacityReservationSpecificationResponse;
const CpuOptions = @import("cpu_options.zig").CpuOptions;
const InstanceBootModeValues = @import("instance_boot_mode_values.zig").InstanceBootModeValues;
const ElasticGpuAssociation = @import("elastic_gpu_association.zig").ElasticGpuAssociation;
const ElasticInferenceAcceleratorAssociation = @import("elastic_inference_accelerator_association.zig").ElasticInferenceAcceleratorAssociation;
const EnclaveOptions = @import("enclave_options.zig").EnclaveOptions;
const HibernationOptions = @import("hibernation_options.zig").HibernationOptions;
const HypervisorType = @import("hypervisor_type.zig").HypervisorType;
const IamInstanceProfile = @import("iam_instance_profile.zig").IamInstanceProfile;
const InstanceLifecycleType = @import("instance_lifecycle_type.zig").InstanceLifecycleType;
const InstanceType = @import("instance_type.zig").InstanceType;
const LicenseConfiguration = @import("license_configuration.zig").LicenseConfiguration;
const InstanceMaintenanceOptions = @import("instance_maintenance_options.zig").InstanceMaintenanceOptions;
const InstanceMetadataOptionsResponse = @import("instance_metadata_options_response.zig").InstanceMetadataOptionsResponse;
const Monitoring = @import("monitoring.zig").Monitoring;
const InstanceNetworkInterface = @import("instance_network_interface.zig").InstanceNetworkInterface;
const InstanceNetworkPerformanceOptions = @import("instance_network_performance_options.zig").InstanceNetworkPerformanceOptions;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const Placement = @import("placement.zig").Placement;
const PlatformValues = @import("platform_values.zig").PlatformValues;
const PrivateDnsNameOptionsResponse = @import("private_dns_name_options_response.zig").PrivateDnsNameOptionsResponse;
const ProductCode = @import("product_code.zig").ProductCode;
const DeviceType = @import("device_type.zig").DeviceType;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const InstanceState = @import("instance_state.zig").InstanceState;
const StateReason = @import("state_reason.zig").StateReason;
const Tag = @import("tag.zig").Tag;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;

/// Describes an instance.
pub const Instance = struct {
    /// The AMI launch index, which can be used to find this instance in the launch
    /// group.
    ami_launch_index: ?i32 = null,

    /// The architecture of the image.
    architecture: ?ArchitectureValues = null,

    /// Any block device mapping entries for the instance.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping = null,

    /// The boot mode that was specified by the AMI. If the value is
    /// `uefi-preferred`,
    /// the AMI supports both UEFI and Legacy BIOS. The `currentInstanceBootMode`
    /// parameter
    /// is the boot mode that is used to boot the instance at launch or start.
    ///
    /// The operating system contained in the AMI must be configured to support the
    /// specified boot mode.
    ///
    /// For more information, see [Boot
    /// modes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html) in
    /// the
    /// *Amazon EC2 User Guide*.
    boot_mode: ?BootModeValues = null,

    /// The ID of the Capacity Block.
    ///
    /// For P5 instances, a Capacity Block ID refers to a group of instances. For
    /// Trn2u
    /// instances, a capacity block ID refers to an EC2 UltraServer.
    capacity_block_id: ?[]const u8 = null,

    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8 = null,

    /// Information about the Capacity Reservation targeting option.
    capacity_reservation_specification: ?CapacityReservationSpecificationResponse = null,

    /// The idempotency token you provided when you launched the instance, if
    /// applicable.
    client_token: ?[]const u8 = null,

    /// The CPU options for the instance.
    cpu_options: ?CpuOptions = null,

    /// The boot mode that is used to boot the instance at launch or start. For more
    /// information, see [Boot
    /// modes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html) in
    /// the
    /// *Amazon EC2 User Guide*.
    current_instance_boot_mode: ?InstanceBootModeValues = null,

    /// Indicates whether the instance is optimized for Amazon EBS I/O. This
    /// optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to
    /// provide optimal I/O performance. This optimization isn't available with all
    /// instance
    /// types. Additional usage charges apply when using an EBS Optimized instance.
    ebs_optimized: ?bool = null,

    /// Deprecated.
    ///
    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    elastic_gpu_associations: ?[]const ElasticGpuAssociation = null,

    /// Deprecated
    ///
    /// Amazon Elastic Inference is no longer available.
    elastic_inference_accelerator_associations: ?[]const ElasticInferenceAcceleratorAssociation = null,

    /// Specifies whether enhanced networking with ENA is enabled.
    ena_support: ?bool = null,

    /// Indicates whether the instance is enabled for Amazon Web Services Nitro
    /// Enclaves.
    enclave_options: ?EnclaveOptions = null,

    /// Indicates whether the instance is enabled for hibernation.
    hibernation_options: ?HibernationOptions = null,

    /// The hypervisor type of the instance. The value `xen` is used for both Xen
    /// and Nitro hypervisors.
    hypervisor: ?HypervisorType = null,

    /// The IAM instance profile associated with the instance, if
    /// applicable.
    iam_instance_profile: ?IamInstanceProfile = null,

    /// The ID of the AMI used to launch the instance.
    image_id: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// Indicates whether this is a Spot Instance or a Scheduled Instance.
    instance_lifecycle: ?InstanceLifecycleType = null,

    /// The instance type.
    instance_type: ?InstanceType = null,

    /// The IPv6 address assigned to the instance.
    ipv_6_address: ?[]const u8 = null,

    /// The kernel associated with this instance, if applicable.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair, if this instance was launched with an associated
    /// key
    /// pair.
    key_name: ?[]const u8 = null,

    /// The time that the instance was last launched. To determine the time that
    /// instance was first launched,
    /// see the attachment time for the primary network interface.
    launch_time: ?i64 = null,

    /// The license configurations for the instance.
    licenses: ?[]const LicenseConfiguration = null,

    /// Provides information on the recovery and maintenance options of your
    /// instance.
    maintenance_options: ?InstanceMaintenanceOptions = null,

    /// The metadata options for the instance.
    metadata_options: ?InstanceMetadataOptionsResponse = null,

    /// The monitoring for the instance.
    monitoring: ?Monitoring = null,

    /// The network interfaces for the instance.
    network_interfaces: ?[]const InstanceNetworkInterface = null,

    /// Contains settings for the network performance options for your instance.
    network_performance_options: ?InstanceNetworkPerformanceOptions = null,

    /// The service provider that manages the instance.
    operator: ?OperatorResponse = null,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// The location where the instance launched, if applicable.
    placement: ?Placement = null,

    /// The platform. This value is `windows` for Windows instances; otherwise, it
    /// is empty.
    platform: ?PlatformValues = null,

    /// The platform details value for the instance. For more information, see [AMI
    /// billing information
    /// fields](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/billing-info-fields.html) in the
    /// *Amazon EC2 User Guide*.
    platform_details: ?[]const u8 = null,

    /// [IPv4 only] The private DNS hostname name assigned to the instance. This DNS
    /// hostname
    /// can only be used inside the Amazon EC2 network. This name is not available
    /// until the
    /// instance enters the `running` state.
    ///
    /// The Amazon-provided DNS server resolves Amazon-provided private DNS
    /// hostnames if you've enabled DNS resolution and DNS hostnames in your VPC. If
    /// you are not
    /// using the Amazon-provided DNS server in your VPC, your custom domain name
    /// servers must
    /// resolve the hostname as appropriate.
    private_dns_name: ?[]const u8 = null,

    /// The options for the instance hostname.
    private_dns_name_options: ?PrivateDnsNameOptionsResponse = null,

    /// The private IPv4 address assigned to the instance.
    private_ip_address: ?[]const u8 = null,

    /// The product codes attached to this instance, if applicable.
    product_codes: ?[]const ProductCode = null,

    /// The public DNS name assigned to the instance. This name is not available
    /// until the instance enters the `running` state. This name is only
    /// available if you've enabled DNS hostnames for your VPC. The format of this
    /// name depends on the [public hostname
    /// type](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hostname-types.html#public-hostnames).
    public_dns_name: ?[]const u8 = null,

    /// The public IPv4 address, or the Carrier IP address assigned to the instance,
    /// if
    /// applicable.
    ///
    /// A Carrier IP address only applies to an instance launched in a subnet
    /// associated with
    /// a Wavelength Zone.
    public_ip_address: ?[]const u8 = null,

    /// The RAM disk associated with this instance, if applicable.
    ramdisk_id: ?[]const u8 = null,

    /// The device name of the root device volume (for example,
    /// `/dev/sda1`).
    root_device_name: ?[]const u8 = null,

    /// The root device type used by the AMI. The AMI can use an EBS volume or an
    /// instance
    /// store volume.
    root_device_type: ?DeviceType = null,

    /// The security groups for the instance.
    security_groups: ?[]const GroupIdentifier = null,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?bool = null,

    /// If the request is a Spot Instance request, the ID of the request.
    spot_instance_request_id: ?[]const u8 = null,

    /// Specifies whether enhanced networking with the Intel 82599 Virtual Function
    /// interface
    /// is enabled.
    sriov_net_support: ?[]const u8 = null,

    /// The current state of the instance.
    state: ?InstanceState = null,

    /// The reason for the most recent state transition.
    state_reason: ?StateReason = null,

    /// The reason for the most recent state transition. This might be an empty
    /// string.
    state_transition_reason: ?[]const u8 = null,

    /// The ID of the subnet in which the instance is running.
    subnet_id: ?[]const u8 = null,

    /// Any tags assigned to the instance.
    tags: ?[]const Tag = null,

    /// If the instance is configured for NitroTPM support, the value is `v2.0`.
    /// For more information, see
    /// [NitroTPM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitrotpm.html) in the
    /// *Amazon EC2 User Guide*.
    tpm_support: ?[]const u8 = null,

    /// The usage operation value for the instance. For more information, see [AMI
    /// billing information
    /// fields](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/billing-info-fields.html) in the
    /// *Amazon EC2 User Guide*.
    usage_operation: ?[]const u8 = null,

    /// The time that the usage operation was last updated.
    usage_operation_update_time: ?i64 = null,

    /// The virtualization type of the instance.
    virtualization_type: ?VirtualizationType = null,

    /// The ID of the VPC in which the instance is running.
    vpc_id: ?[]const u8 = null,
};
