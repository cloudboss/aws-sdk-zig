const LaunchTemplateBlockDeviceMappingRequest = @import("launch_template_block_device_mapping_request.zig").LaunchTemplateBlockDeviceMappingRequest;
const LaunchTemplateCapacityReservationSpecificationRequest = @import("launch_template_capacity_reservation_specification_request.zig").LaunchTemplateCapacityReservationSpecificationRequest;
const LaunchTemplateCpuOptionsRequest = @import("launch_template_cpu_options_request.zig").LaunchTemplateCpuOptionsRequest;
const CreditSpecificationRequest = @import("credit_specification_request.zig").CreditSpecificationRequest;
const ElasticGpuSpecification = @import("elastic_gpu_specification.zig").ElasticGpuSpecification;
const LaunchTemplateElasticInferenceAccelerator = @import("launch_template_elastic_inference_accelerator.zig").LaunchTemplateElasticInferenceAccelerator;
const LaunchTemplateEnclaveOptionsRequest = @import("launch_template_enclave_options_request.zig").LaunchTemplateEnclaveOptionsRequest;
const LaunchTemplateHibernationOptionsRequest = @import("launch_template_hibernation_options_request.zig").LaunchTemplateHibernationOptionsRequest;
const LaunchTemplateIamInstanceProfileSpecificationRequest = @import("launch_template_iam_instance_profile_specification_request.zig").LaunchTemplateIamInstanceProfileSpecificationRequest;
const ShutdownBehavior = @import("shutdown_behavior.zig").ShutdownBehavior;
const LaunchTemplateInstanceMarketOptionsRequest = @import("launch_template_instance_market_options_request.zig").LaunchTemplateInstanceMarketOptionsRequest;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const InstanceType = @import("instance_type.zig").InstanceType;
const LaunchTemplateLicenseConfigurationRequest = @import("launch_template_license_configuration_request.zig").LaunchTemplateLicenseConfigurationRequest;
const LaunchTemplateInstanceMaintenanceOptionsRequest = @import("launch_template_instance_maintenance_options_request.zig").LaunchTemplateInstanceMaintenanceOptionsRequest;
const LaunchTemplateInstanceMetadataOptionsRequest = @import("launch_template_instance_metadata_options_request.zig").LaunchTemplateInstanceMetadataOptionsRequest;
const LaunchTemplatesMonitoringRequest = @import("launch_templates_monitoring_request.zig").LaunchTemplatesMonitoringRequest;
const LaunchTemplateInstanceNetworkInterfaceSpecificationRequest = @import("launch_template_instance_network_interface_specification_request.zig").LaunchTemplateInstanceNetworkInterfaceSpecificationRequest;
const LaunchTemplateNetworkPerformanceOptionsRequest = @import("launch_template_network_performance_options_request.zig").LaunchTemplateNetworkPerformanceOptionsRequest;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const LaunchTemplatePlacementRequest = @import("launch_template_placement_request.zig").LaunchTemplatePlacementRequest;
const LaunchTemplatePrivateDnsNameOptionsRequest = @import("launch_template_private_dns_name_options_request.zig").LaunchTemplatePrivateDnsNameOptionsRequest;
const LaunchTemplateTagSpecificationRequest = @import("launch_template_tag_specification_request.zig").LaunchTemplateTagSpecificationRequest;

/// The information to include in the launch template.
///
/// You must specify at least one parameter for the launch template data.
pub const RequestLaunchTemplateData = struct {
    /// The block device mapping.
    block_device_mappings: ?[]const LaunchTemplateBlockDeviceMappingRequest,

    /// The Capacity Reservation targeting option. If you do not specify this
    /// parameter, the
    /// instance's Capacity Reservation preference defaults to `open`, which enables
    /// it to run in any open Capacity Reservation that has matching attributes
    /// (instance type,
    /// platform, Availability Zone).
    capacity_reservation_specification: ?LaunchTemplateCapacityReservationSpecificationRequest,

    /// The CPU options for the instance. For more information, see [CPU
    /// options for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the
    /// *Amazon EC2 User Guide*.
    cpu_options: ?LaunchTemplateCpuOptionsRequest,

    /// The credit option for CPU usage of the instance. Valid only for T instances.
    credit_specification: ?CreditSpecificationRequest,

    /// Indicates whether to enable the instance for stop protection. For more
    /// information,
    /// see [Enable stop protection for your EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-stop-protection.html) in the
    /// *Amazon EC2 User Guide*.
    disable_api_stop: ?bool,

    /// Indicates whether termination protection is enabled for the instance. The
    /// default is
    /// `false`, which means that you can terminate the instance using the Amazon
    /// EC2
    /// console, command line tools, or API. You can enable termination protection
    /// when you
    /// launch an instance, while the instance is running, or while the instance is
    /// stopped.
    disable_api_termination: ?bool,

    /// Indicates whether the instance is optimized for Amazon EBS I/O. This
    /// optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to
    /// provide optimal Amazon EBS I/O performance. This optimization isn't
    /// available with all
    /// instance types. Additional usage charges apply when using an EBS-optimized
    /// instance.
    ebs_optimized: ?bool,

    /// Deprecated.
    ///
    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    elastic_gpu_specifications: ?[]const ElasticGpuSpecification,

    /// Amazon Elastic Inference is no longer available.
    ///
    /// An elastic inference accelerator to associate with the instance. Elastic
    /// inference
    /// accelerators are a resource you can attach to your Amazon EC2 instances to
    /// accelerate
    /// your Deep Learning (DL) inference workloads.
    ///
    /// You cannot specify accelerators from different generations in the same
    /// request.
    elastic_inference_accelerators: ?[]const LaunchTemplateElasticInferenceAccelerator,

    /// Indicates whether the instance is enabled for Amazon Web Services Nitro
    /// Enclaves. For more
    /// information, see [What is Nitro
    /// Enclaves?](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html) in the
    /// *Amazon Web Services Nitro Enclaves User Guide*.
    ///
    /// You can't enable Amazon Web Services Nitro Enclaves and hibernation on the
    /// same instance.
    enclave_options: ?LaunchTemplateEnclaveOptionsRequest,

    /// Indicates whether an instance is enabled for hibernation. This parameter is
    /// valid only
    /// if the instance meets the [hibernation
    /// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). For more information, see [Hibernate your Amazon EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html)
    /// in the *Amazon EC2 User Guide*.
    hibernation_options: ?LaunchTemplateHibernationOptionsRequest,

    /// The name or Amazon Resource Name (ARN) of an IAM instance profile.
    iam_instance_profile: ?LaunchTemplateIamInstanceProfileSpecificationRequest,

    /// The ID of the AMI in the format `ami-0ac394d6a3example`.
    ///
    /// Alternatively, you can specify a Systems Manager parameter, using one of the
    /// following
    /// formats. The Systems Manager parameter will resolve to an AMI ID on launch.
    ///
    /// To reference a public parameter:
    ///
    /// * `resolve:ssm:*public-parameter*
    /// `
    ///
    /// To reference a parameter stored in the same account:
    ///
    /// * `resolve:ssm:*parameter-name*
    /// `
    ///
    /// * `resolve:ssm:*parameter-name:version-number*
    /// `
    ///
    /// * `resolve:ssm:*parameter-name:label*
    /// `
    ///
    /// To reference a parameter shared from another Amazon Web Services account:
    ///
    /// * `resolve:ssm:*parameter-ARN*
    /// `
    ///
    /// * `resolve:ssm:*parameter-ARN:version-number*
    /// `
    ///
    /// * `resolve:ssm:*parameter-ARN:label*
    /// `
    ///
    /// For more information, see [Use a Systems Manager parameter instead of an AMI
    /// ID](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// If the launch template will be used for an EC2 Fleet or Spot Fleet, note the
    /// following:
    ///
    /// * Only EC2 Fleets of type `instant` support specifying a Systems
    /// Manager parameter.
    ///
    /// * For EC2 Fleets of type `maintain` or `request`, or
    /// for Spot Fleets, you must specify the AMI ID.
    image_id: ?[]const u8,

    /// Indicates whether an instance stops or terminates when you initiate shutdown
    /// from the
    /// instance (using the operating system command for system shutdown).
    ///
    /// Default: `stop`
    instance_initiated_shutdown_behavior: ?ShutdownBehavior,

    /// The market (purchasing) option for the instances.
    instance_market_options: ?LaunchTemplateInstanceMarketOptionsRequest,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with these attributes.
    ///
    /// You must specify `VCpuCount` and `MemoryMiB`. All other attributes
    /// are optional. Any unspecified optional attribute is set to its default.
    ///
    /// When you specify multiple attributes, you get instance types that satisfy
    /// all of the
    /// specified attributes. If you specify multiple values for an attribute, you
    /// get instance
    /// types that satisfy any of the specified values.
    ///
    /// To limit the list of instance types from which Amazon EC2 can identify
    /// matching instance types,
    /// you can use one of the following parameters, but not both in the same
    /// request:
    ///
    /// * `AllowedInstanceTypes` - The instance types to include in the list. All
    /// other instance types are ignored, even if they match your specified
    /// attributes.
    ///
    /// * `ExcludedInstanceTypes` - The instance types to exclude from the list,
    /// even if they match your specified attributes.
    ///
    /// If you specify `InstanceRequirements`, you can't specify
    /// `InstanceType`.
    ///
    /// Attribute-based instance type selection is only supported when using Auto
    /// Scaling
    /// groups, EC2 Fleet, and Spot Fleet to launch instances. If you plan to use
    /// the launch template in
    /// the [launch instance
    /// wizard](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-instance-wizard.html), or with the [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html) API or
    /// [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-instance.html) Amazon Web Services CloudFormation resource, you can't specify `InstanceRequirements`.
    ///
    /// For more information, see [Specify attributes for instance type selection
    /// for EC2 Fleet or Spot
    /// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html) and [Spot
    /// placement
    /// score](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in the *Amazon EC2 User Guide*.
    instance_requirements: ?InstanceRequirementsRequest,

    /// The instance type. For more information, see [Amazon EC2 instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in
    /// the *Amazon EC2 User Guide*.
    ///
    /// If you specify `InstanceType`, you can't specify
    /// `InstanceRequirements`.
    instance_type: ?InstanceType,

    /// The ID of the kernel.
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see [User provided
    /// kernels](https://docs.aws.amazon.com/linux/al2/ug/UserProvidedKernels.html)
    /// in the
    /// *Amazon Linux 2 User Guide*.
    kernel_id: ?[]const u8,

    /// The name of the key pair. You can create a key pair using
    /// [CreateKeyPair](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateKeyPair.html) or
    /// [ImportKeyPair](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportKeyPair.html).
    ///
    /// If you do not specify a key pair, you can't connect to the instance unless
    /// you
    /// choose an AMI that is configured to allow users another way to log in.
    key_name: ?[]const u8,

    /// The license configurations.
    license_specifications: ?[]const LaunchTemplateLicenseConfigurationRequest,

    /// The maintenance options for the instance.
    maintenance_options: ?LaunchTemplateInstanceMaintenanceOptionsRequest,

    /// The metadata options for the instance. For more information, see [Configure
    /// the Instance Metadata Service
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html) in the
    /// *Amazon EC2 User Guide*.
    metadata_options: ?LaunchTemplateInstanceMetadataOptionsRequest,

    /// The monitoring for the instance.
    monitoring: ?LaunchTemplatesMonitoringRequest,

    /// The network interfaces for the instance.
    network_interfaces: ?[]const LaunchTemplateInstanceNetworkInterfaceSpecificationRequest,

    /// Contains launch template settings to boost network performance for the type
    /// of
    /// workload that runs on your instance.
    network_performance_options: ?LaunchTemplateNetworkPerformanceOptionsRequest,

    /// The entity that manages the launch template.
    operator: ?OperatorRequest,

    /// The placement for the instance.
    placement: ?LaunchTemplatePlacementRequest,

    /// The options for the instance hostname. The default values are inherited from
    /// the
    /// subnet.
    private_dns_name_options: ?LaunchTemplatePrivateDnsNameOptionsRequest,

    /// The ID of the RAM disk.
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see [User provided
    /// kernels](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the *Amazon EC2 User Guide*.
    ram_disk_id: ?[]const u8,

    /// The IDs of the security groups.
    ///
    /// If you specify a network interface, you must specify any security groups as
    /// part of
    /// the network interface instead of using this parameter.
    security_group_ids: ?[]const []const u8,

    /// The names of the security groups. For a nondefault VPC, you must use
    /// security group
    /// IDs instead.
    ///
    /// If you specify a network interface, you must specify any security groups as
    /// part of
    /// the network interface instead of using this parameter.
    security_groups: ?[]const []const u8,

    /// The tags to apply to the resources that are created during instance launch.
    /// These tags
    /// are not applied to the launch template.
    tag_specifications: ?[]const LaunchTemplateTagSpecificationRequest,

    /// The user data to make available to the instance. You must provide
    /// base64-encoded text.
    /// User data is limited to 16 KB. For more information, see [Run commands when
    /// you launch an EC2
    /// instance with user data
    /// input](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
    /// in the
    /// *Amazon EC2 User Guide*.
    ///
    /// If you are creating the launch template for use with Batch, the user
    /// data must be provided in the [MIME multi-part archive
    /// format](https://cloudinit.readthedocs.io/en/latest/topics/format.html#mime-multi-part-archive). For more information, see [Amazon EC2 user data in launch templates](https://docs.aws.amazon.com/batch/latest/userguide/launch-templates.html#lt-user-data) in the
    /// *Batch User Guide*.
    user_data: ?[]const u8,
};
