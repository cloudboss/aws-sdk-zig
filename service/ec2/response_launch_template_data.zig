const LaunchTemplateBlockDeviceMapping = @import("launch_template_block_device_mapping.zig").LaunchTemplateBlockDeviceMapping;
const LaunchTemplateCapacityReservationSpecificationResponse = @import("launch_template_capacity_reservation_specification_response.zig").LaunchTemplateCapacityReservationSpecificationResponse;
const LaunchTemplateCpuOptions = @import("launch_template_cpu_options.zig").LaunchTemplateCpuOptions;
const CreditSpecification = @import("credit_specification.zig").CreditSpecification;
const ElasticGpuSpecificationResponse = @import("elastic_gpu_specification_response.zig").ElasticGpuSpecificationResponse;
const LaunchTemplateElasticInferenceAcceleratorResponse = @import("launch_template_elastic_inference_accelerator_response.zig").LaunchTemplateElasticInferenceAcceleratorResponse;
const LaunchTemplateEnclaveOptions = @import("launch_template_enclave_options.zig").LaunchTemplateEnclaveOptions;
const LaunchTemplateHibernationOptions = @import("launch_template_hibernation_options.zig").LaunchTemplateHibernationOptions;
const LaunchTemplateIamInstanceProfileSpecification = @import("launch_template_iam_instance_profile_specification.zig").LaunchTemplateIamInstanceProfileSpecification;
const ShutdownBehavior = @import("shutdown_behavior.zig").ShutdownBehavior;
const LaunchTemplateInstanceMarketOptions = @import("launch_template_instance_market_options.zig").LaunchTemplateInstanceMarketOptions;
const InstanceRequirements = @import("instance_requirements.zig").InstanceRequirements;
const InstanceType = @import("instance_type.zig").InstanceType;
const LaunchTemplateLicenseConfiguration = @import("launch_template_license_configuration.zig").LaunchTemplateLicenseConfiguration;
const LaunchTemplateInstanceMaintenanceOptions = @import("launch_template_instance_maintenance_options.zig").LaunchTemplateInstanceMaintenanceOptions;
const LaunchTemplateInstanceMetadataOptions = @import("launch_template_instance_metadata_options.zig").LaunchTemplateInstanceMetadataOptions;
const LaunchTemplatesMonitoring = @import("launch_templates_monitoring.zig").LaunchTemplatesMonitoring;
const LaunchTemplateInstanceNetworkInterfaceSpecification = @import("launch_template_instance_network_interface_specification.zig").LaunchTemplateInstanceNetworkInterfaceSpecification;
const LaunchTemplateNetworkPerformanceOptions = @import("launch_template_network_performance_options.zig").LaunchTemplateNetworkPerformanceOptions;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const LaunchTemplatePlacement = @import("launch_template_placement.zig").LaunchTemplatePlacement;
const LaunchTemplatePrivateDnsNameOptions = @import("launch_template_private_dns_name_options.zig").LaunchTemplatePrivateDnsNameOptions;
const LaunchTemplateTagSpecification = @import("launch_template_tag_specification.zig").LaunchTemplateTagSpecification;

/// The information for a launch template.
pub const ResponseLaunchTemplateData = struct {
    /// The block device mappings.
    block_device_mappings: ?[]const LaunchTemplateBlockDeviceMapping,

    /// Information about the Capacity Reservation targeting option.
    capacity_reservation_specification: ?LaunchTemplateCapacityReservationSpecificationResponse,

    /// The CPU options for the instance. For more information, see [CPU
    /// options for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the
    /// *Amazon EC2 User Guide*.
    cpu_options: ?LaunchTemplateCpuOptions,

    /// The credit option for CPU usage of the instance.
    credit_specification: ?CreditSpecification,

    /// Indicates whether the instance is enabled for stop protection. For more
    /// information,
    /// see [Enable stop protection for your EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-stop-protection.html) in the
    /// *Amazon EC2 User Guide*.
    disable_api_stop: ?bool,

    /// If set to `true`, indicates that the instance cannot be terminated using
    /// the Amazon EC2 console, command line tool, or API.
    disable_api_termination: ?bool,

    /// Indicates whether the instance is optimized for Amazon EBS I/O.
    ebs_optimized: ?bool,

    /// Deprecated.
    ///
    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    elastic_gpu_specifications: ?[]const ElasticGpuSpecificationResponse,

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
    elastic_inference_accelerators: ?[]const LaunchTemplateElasticInferenceAcceleratorResponse,

    /// Indicates whether the instance is enabled for Amazon Web Services Nitro
    /// Enclaves.
    enclave_options: ?LaunchTemplateEnclaveOptions,

    /// Indicates whether an instance is configured for hibernation. For more
    /// information, see
    /// [Hibernate
    /// your Amazon EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
    hibernation_options: ?LaunchTemplateHibernationOptions,

    /// The IAM instance profile.
    iam_instance_profile: ?LaunchTemplateIamInstanceProfileSpecification,

    /// The ID of the AMI or a Systems Manager parameter. The Systems Manager
    /// parameter will
    /// resolve to the ID of the AMI at instance launch.
    ///
    /// The value depends on what you specified in the request. The possible values
    /// are:
    ///
    /// * If an AMI ID was specified in the request, then this is the AMI ID.
    ///
    /// * If a Systems Manager parameter was specified in the request, and
    /// `ResolveAlias` was configured as `true`, then this is
    /// the AMI ID that the parameter is mapped to in the Parameter Store.
    ///
    /// * If a Systems Manager parameter was specified in the request, and
    /// `ResolveAlias` was configured as `false`, then this is
    /// the parameter value.
    ///
    /// For more information, see [Use a Systems Manager parameter instead of an AMI
    /// ID](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id) in the
    /// *Amazon EC2 User Guide*.
    image_id: ?[]const u8,

    /// Indicates whether an instance stops or terminates when you initiate shutdown
    /// from the
    /// instance (using the operating system command for system shutdown).
    instance_initiated_shutdown_behavior: ?ShutdownBehavior,

    /// The market (purchasing) option for the instances.
    instance_market_options: ?LaunchTemplateInstanceMarketOptions,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with these attributes.
    ///
    /// If you specify `InstanceRequirements`, you can't specify
    /// `InstanceTypes`.
    instance_requirements: ?InstanceRequirements,

    /// The instance type.
    instance_type: ?InstanceType,

    /// The ID of the kernel, if applicable.
    kernel_id: ?[]const u8,

    /// The name of the key pair.
    key_name: ?[]const u8,

    /// The license configurations.
    license_specifications: ?[]const LaunchTemplateLicenseConfiguration,

    /// The maintenance options for your instance.
    maintenance_options: ?LaunchTemplateInstanceMaintenanceOptions,

    /// The metadata options for the instance. For more information, see [Configure
    /// the Instance Metadata Service
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html) in the
    /// *Amazon EC2 User Guide*.
    metadata_options: ?LaunchTemplateInstanceMetadataOptions,

    /// The monitoring for the instance.
    monitoring: ?LaunchTemplatesMonitoring,

    /// The network interfaces.
    network_interfaces: ?[]const LaunchTemplateInstanceNetworkInterfaceSpecification,

    /// Contains the launch template settings for network performance options for
    /// your
    /// instance.
    network_performance_options: ?LaunchTemplateNetworkPerformanceOptions,

    /// The entity that manages the launch template.
    operator: ?OperatorResponse,

    /// The placement of the instance.
    placement: ?LaunchTemplatePlacement,

    /// The options for the instance hostname.
    private_dns_name_options: ?LaunchTemplatePrivateDnsNameOptions,

    /// The ID of the RAM disk, if applicable.
    ram_disk_id: ?[]const u8,

    /// The security group IDs.
    security_group_ids: ?[]const []const u8,

    /// The security group names.
    security_groups: ?[]const []const u8,

    /// The tags that are applied to the resources that are created during instance
    /// launch.
    tag_specifications: ?[]const LaunchTemplateTagSpecification,

    /// The user data for the instance.
    user_data: ?[]const u8,
};
