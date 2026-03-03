const AwsEc2LaunchTemplateDataBlockDeviceMappingSetDetails = @import("aws_ec_2_launch_template_data_block_device_mapping_set_details.zig").AwsEc2LaunchTemplateDataBlockDeviceMappingSetDetails;
const AwsEc2LaunchTemplateDataCapacityReservationSpecificationDetails = @import("aws_ec_2_launch_template_data_capacity_reservation_specification_details.zig").AwsEc2LaunchTemplateDataCapacityReservationSpecificationDetails;
const AwsEc2LaunchTemplateDataCpuOptionsDetails = @import("aws_ec_2_launch_template_data_cpu_options_details.zig").AwsEc2LaunchTemplateDataCpuOptionsDetails;
const AwsEc2LaunchTemplateDataCreditSpecificationDetails = @import("aws_ec_2_launch_template_data_credit_specification_details.zig").AwsEc2LaunchTemplateDataCreditSpecificationDetails;
const AwsEc2LaunchTemplateDataElasticGpuSpecificationSetDetails = @import("aws_ec_2_launch_template_data_elastic_gpu_specification_set_details.zig").AwsEc2LaunchTemplateDataElasticGpuSpecificationSetDetails;
const AwsEc2LaunchTemplateDataElasticInferenceAcceleratorSetDetails = @import("aws_ec_2_launch_template_data_elastic_inference_accelerator_set_details.zig").AwsEc2LaunchTemplateDataElasticInferenceAcceleratorSetDetails;
const AwsEc2LaunchTemplateDataEnclaveOptionsDetails = @import("aws_ec_2_launch_template_data_enclave_options_details.zig").AwsEc2LaunchTemplateDataEnclaveOptionsDetails;
const AwsEc2LaunchTemplateDataHibernationOptionsDetails = @import("aws_ec_2_launch_template_data_hibernation_options_details.zig").AwsEc2LaunchTemplateDataHibernationOptionsDetails;
const AwsEc2LaunchTemplateDataIamInstanceProfileDetails = @import("aws_ec_2_launch_template_data_iam_instance_profile_details.zig").AwsEc2LaunchTemplateDataIamInstanceProfileDetails;
const AwsEc2LaunchTemplateDataInstanceMarketOptionsDetails = @import("aws_ec_2_launch_template_data_instance_market_options_details.zig").AwsEc2LaunchTemplateDataInstanceMarketOptionsDetails;
const AwsEc2LaunchTemplateDataInstanceRequirementsDetails = @import("aws_ec_2_launch_template_data_instance_requirements_details.zig").AwsEc2LaunchTemplateDataInstanceRequirementsDetails;
const AwsEc2LaunchTemplateDataLicenseSetDetails = @import("aws_ec_2_launch_template_data_license_set_details.zig").AwsEc2LaunchTemplateDataLicenseSetDetails;
const AwsEc2LaunchTemplateDataMaintenanceOptionsDetails = @import("aws_ec_2_launch_template_data_maintenance_options_details.zig").AwsEc2LaunchTemplateDataMaintenanceOptionsDetails;
const AwsEc2LaunchTemplateDataMetadataOptionsDetails = @import("aws_ec_2_launch_template_data_metadata_options_details.zig").AwsEc2LaunchTemplateDataMetadataOptionsDetails;
const AwsEc2LaunchTemplateDataMonitoringDetails = @import("aws_ec_2_launch_template_data_monitoring_details.zig").AwsEc2LaunchTemplateDataMonitoringDetails;
const AwsEc2LaunchTemplateDataNetworkInterfaceSetDetails = @import("aws_ec_2_launch_template_data_network_interface_set_details.zig").AwsEc2LaunchTemplateDataNetworkInterfaceSetDetails;
const AwsEc2LaunchTemplateDataPlacementDetails = @import("aws_ec_2_launch_template_data_placement_details.zig").AwsEc2LaunchTemplateDataPlacementDetails;
const AwsEc2LaunchTemplateDataPrivateDnsNameOptionsDetails = @import("aws_ec_2_launch_template_data_private_dns_name_options_details.zig").AwsEc2LaunchTemplateDataPrivateDnsNameOptionsDetails;

/// The information to include in an Amazon Elastic Compute Cloud (Amazon EC2)
/// launch template.
pub const AwsEc2LaunchTemplateDataDetails = struct {
    /// Information about a block device mapping for an Amazon EC2 launch template.
    block_device_mapping_set: ?[]const AwsEc2LaunchTemplateDataBlockDeviceMappingSetDetails = null,

    /// Specifies an instance's Capacity Reservation targeting option. You can
    /// specify only
    /// one option at a time.
    capacity_reservation_specification: ?AwsEc2LaunchTemplateDataCapacityReservationSpecificationDetails = null,

    /// Specifies the CPU options for an instance. For more information, see
    /// [Optimize CPU
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the *Amazon Elastic Compute Cloud User Guide*.
    cpu_options: ?AwsEc2LaunchTemplateDataCpuOptionsDetails = null,

    /// Specifies the credit option for CPU usage of a T2, T3, or T3a instance.
    credit_specification: ?AwsEc2LaunchTemplateDataCreditSpecificationDetails = null,

    /// Indicates whether to enable the instance for stop protection. For more
    /// information,
    /// see [Enable stop
    /// protection](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html#Using_StopProtection) in the *Amazon EC2 User Guide*.
    disable_api_stop: ?bool = null,

    /// If you set this parameter to `true`, you can't terminate the instance using
    /// the Amazon EC2 console, CLI, or API. If set to `true`, you can.
    disable_api_termination: ?bool = null,

    /// Indicates whether the instance is optimized for Amazon EBS I/O.
    ebs_optimized: ?bool = null,

    /// Provides details about Elastic Graphics accelerators to associate with the
    /// instance.
    elastic_gpu_specification_set: ?[]const AwsEc2LaunchTemplateDataElasticGpuSpecificationSetDetails = null,

    /// The Amazon Elastic Inference accelerator for the instance.
    elastic_inference_accelerator_set: ?[]const AwsEc2LaunchTemplateDataElasticInferenceAcceleratorSetDetails = null,

    /// Indicates whether the Amazon EC2 instance is enabled for Amazon Web Services
    /// Nitro Enclaves.
    enclave_options: ?AwsEc2LaunchTemplateDataEnclaveOptionsDetails = null,

    /// Specifies whether your Amazon EC2 instance is configured for hibernation.
    hibernation_options: ?AwsEc2LaunchTemplateDataHibernationOptionsDetails = null,

    /// The name or Amazon Resource Name (ARN) of an IAM instance profile.
    iam_instance_profile: ?AwsEc2LaunchTemplateDataIamInstanceProfileDetails = null,

    /// The ID of the Amazon Machine Image (AMI).
    image_id: ?[]const u8 = null,

    /// Provides the options for specifying the instance initiated shutdown
    /// behavior.
    instance_initiated_shutdown_behavior: ?[]const u8 = null,

    /// Specifies the market (purchasing) option for an instance.
    instance_market_options: ?AwsEc2LaunchTemplateDataInstanceMarketOptionsDetails = null,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will identify instance
    /// types with these attributes. If you specify `InstanceRequirements`, you
    /// can't specify `InstanceType`.
    instance_requirements: ?AwsEc2LaunchTemplateDataInstanceRequirementsDetails = null,

    /// The instance type. For more information, see [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2 User Guide*. If you specify `InstanceType`, you can't
    /// specify `InstanceRequirements`.
    instance_type: ?[]const u8 = null,

    /// The ID of the kernel.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair that allows users to connect to the instance.
    key_name: ?[]const u8 = null,

    /// Specifies a license configuration for an instance.
    license_set: ?[]const AwsEc2LaunchTemplateDataLicenseSetDetails = null,

    /// The maintenance options of your instance.
    maintenance_options: ?AwsEc2LaunchTemplateDataMaintenanceOptionsDetails = null,

    /// The metadata options for the instance. For more information, see [Instance
    /// metadata and user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) in the *Amazon EC2 User Guide*.
    metadata_options: ?AwsEc2LaunchTemplateDataMetadataOptionsDetails = null,

    /// The monitoring for the instance.
    monitoring: ?AwsEc2LaunchTemplateDataMonitoringDetails = null,

    /// Specifies the parameters for a network interface that is attached to the
    /// instance.
    network_interface_set: ?[]const AwsEc2LaunchTemplateDataNetworkInterfaceSetDetails = null,

    /// Specifies the placement of an instance.
    placement: ?AwsEc2LaunchTemplateDataPlacementDetails = null,

    /// The options for the instance hostname.
    private_dns_name_options: ?AwsEc2LaunchTemplateDataPrivateDnsNameOptionsDetails = null,

    /// The ID of the RAM disk.
    ram_disk_id: ?[]const u8 = null,

    /// One or more security group IDs.
    security_group_id_set: ?[]const []const u8 = null,

    /// One or more security group names. For a nondefault VPC, you must use
    /// security group IDs instead. You cannot specify both a security group ID and
    /// security name in the same request.
    security_group_set: ?[]const []const u8 = null,

    /// The user data to make available to the instance.
    user_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .block_device_mapping_set = "BlockDeviceMappingSet",
        .capacity_reservation_specification = "CapacityReservationSpecification",
        .cpu_options = "CpuOptions",
        .credit_specification = "CreditSpecification",
        .disable_api_stop = "DisableApiStop",
        .disable_api_termination = "DisableApiTermination",
        .ebs_optimized = "EbsOptimized",
        .elastic_gpu_specification_set = "ElasticGpuSpecificationSet",
        .elastic_inference_accelerator_set = "ElasticInferenceAcceleratorSet",
        .enclave_options = "EnclaveOptions",
        .hibernation_options = "HibernationOptions",
        .iam_instance_profile = "IamInstanceProfile",
        .image_id = "ImageId",
        .instance_initiated_shutdown_behavior = "InstanceInitiatedShutdownBehavior",
        .instance_market_options = "InstanceMarketOptions",
        .instance_requirements = "InstanceRequirements",
        .instance_type = "InstanceType",
        .kernel_id = "KernelId",
        .key_name = "KeyName",
        .license_set = "LicenseSet",
        .maintenance_options = "MaintenanceOptions",
        .metadata_options = "MetadataOptions",
        .monitoring = "Monitoring",
        .network_interface_set = "NetworkInterfaceSet",
        .placement = "Placement",
        .private_dns_name_options = "PrivateDnsNameOptions",
        .ram_disk_id = "RamDiskId",
        .security_group_id_set = "SecurityGroupIdSet",
        .security_group_set = "SecurityGroupSet",
        .user_data = "UserData",
    };
};
