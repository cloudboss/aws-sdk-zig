const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const CpuOptionsRequest = @import("cpu_options_request.zig").CpuOptionsRequest;
const CreditSpecificationRequest = @import("credit_specification_request.zig").CreditSpecificationRequest;
const ElasticGpuSpecification = @import("elastic_gpu_specification.zig").ElasticGpuSpecification;
const ElasticInferenceAccelerator = @import("elastic_inference_accelerator.zig").ElasticInferenceAccelerator;
const EnclaveOptionsRequest = @import("enclave_options_request.zig").EnclaveOptionsRequest;
const HibernationOptionsRequest = @import("hibernation_options_request.zig").HibernationOptionsRequest;
const IamInstanceProfileSpecification = @import("iam_instance_profile_specification.zig").IamInstanceProfileSpecification;
const ShutdownBehavior = @import("shutdown_behavior.zig").ShutdownBehavior;
const InstanceMarketOptionsRequest = @import("instance_market_options_request.zig").InstanceMarketOptionsRequest;
const InstanceType = @import("instance_type.zig").InstanceType;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const LicenseConfigurationRequest = @import("license_configuration_request.zig").LicenseConfigurationRequest;
const InstanceMaintenanceOptionsRequest = @import("instance_maintenance_options_request.zig").InstanceMaintenanceOptionsRequest;
const InstanceMetadataOptionsRequest = @import("instance_metadata_options_request.zig").InstanceMetadataOptionsRequest;
const RunInstancesMonitoringEnabled = @import("run_instances_monitoring_enabled.zig").RunInstancesMonitoringEnabled;
const InstanceNetworkInterfaceSpecification = @import("instance_network_interface_specification.zig").InstanceNetworkInterfaceSpecification;
const InstanceNetworkPerformanceOptionsRequest = @import("instance_network_performance_options_request.zig").InstanceNetworkPerformanceOptionsRequest;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const Placement = @import("placement.zig").Placement;
const PrivateDnsNameOptionsRequest = @import("private_dns_name_options_request.zig").PrivateDnsNameOptionsRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const Instance = @import("instance.zig").Instance;
const serde = @import("serde.zig");

/// Launches the specified number of instances using an AMI for which you have
/// permissions.
///
/// You can specify a number of options, or leave the default options. The
/// following rules
/// apply:
///
/// * If you don't specify a subnet ID, we choose a default subnet from
/// your default VPC for you. If you don't have a default VPC, you must specify
/// a
/// subnet ID in the request.
///
/// * All instances have a network interface with a primary private IPv4
/// address. If you don't specify this address, we choose one from the IPv4
/// range of
/// your subnet.
///
/// * Not all instance types support IPv6 addresses. For more information, see
/// [Instance
/// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html).
///
/// * If you don't specify a security group ID, we use the default security
///   group
/// for the VPC. For more information, see [Security
/// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html).
///
/// * If any of the AMIs have a product code attached for which the user has not
/// subscribed, the request fails.
///
/// You can create a [launch
/// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html),
/// which is a resource that contains the parameters to launch an instance. When
/// you launch
/// an instance using RunInstances, you can specify the launch template
/// instead of specifying the launch parameters.
///
/// To ensure faster instance launches, break up large requests into smaller
/// batches. For
/// example, create five separate launch requests for 100 instances each instead
/// of one
/// launch request for 500 instances.
///
/// `RunInstances` is subject to both request rate limiting and resource rate
/// limiting. For more information, see [Request
/// throttling](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-throttling.html).
///
/// An instance is ready for you to use when it's in the `running` state. You
/// can check the state of your instance using DescribeInstances. You can
/// tag instances and EBS volumes during launch, after launch, or both. For more
/// information, see CreateTags and [Tagging your Amazon EC2
/// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html).
///
/// Linux instances have access to the public key of the key pair at boot. You
/// can use
/// this key to provide secure access to the instance. Amazon EC2 public images
/// use this
/// feature to provide secure access without passwords. For more information,
/// see [Key
/// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).
///
/// For troubleshooting, see [What to do if
/// an instance immediately
/// terminates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_InstanceStraightToTerminated.html), and [Troubleshooting connecting to your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html).
pub const RunInstancesInput = struct {
    /// Reserved.
    additional_info: ?[]const u8 = null,

    /// The block device mapping, which defines the EBS volumes and instance store
    /// volumes to
    /// attach to the instance at launch. For more information, see [Block device
    /// mappings](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html) in the *Amazon EC2 User Guide*.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// Information about the Capacity Reservation targeting option. If you do not
    /// specify this parameter, the
    /// instance's Capacity Reservation preference defaults to `open`, which enables
    /// it to run in any open Capacity Reservation that has matching attributes
    /// (instance type,
    /// platform, Availability Zone, and tenancy).
    capacity_reservation_specification: ?CapacityReservationSpecification = null,

    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the
    /// request. If you do not specify a client token, a randomly generated token is
    /// used for
    /// the request to ensure idempotency.
    ///
    /// For more information, see [Ensuring idempotency in Amazon EC2 API
    /// requests](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    ///
    /// Constraints: Maximum 64 ASCII characters
    client_token: ?[]const u8 = null,

    /// The CPU options for the instance. For more information, see [Optimize CPU
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the *Amazon EC2 User Guide*.
    cpu_options: ?CpuOptionsRequest = null,

    /// The credit option for CPU usage of the burstable performance instance. Valid
    /// values
    /// are `standard` and `unlimited`. To change this attribute after
    /// launch, use [
    /// ModifyInstanceCreditSpecification](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceCreditSpecification.html). For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    ///
    /// Default: `standard` (T2 instances) or `unlimited` (T3/T3a/T4g
    /// instances)
    ///
    /// For T3 instances with `host` tenancy, only `standard` is
    /// supported.
    credit_specification: ?CreditSpecificationRequest = null,

    /// Indicates whether an instance is enabled for stop protection. For more
    /// information,
    /// see [Enable stop protection for your EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-stop-protection.html).
    disable_api_stop: ?bool = null,

    /// Indicates whether termination protection is enabled for the instance. The
    /// default
    /// is `false`, which means that you can terminate the instance using
    /// the Amazon EC2 console, command line tools, or API. You can enable
    /// termination protection
    /// when you launch an instance, while the instance is running, or while the
    /// instance
    /// is stopped.
    disable_api_termination: ?bool = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether the instance is optimized for Amazon EBS I/O. This
    /// optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to
    /// provide optimal Amazon EBS I/O performance. This optimization isn't
    /// available with all
    /// instance types. Additional usage charges apply when using an EBS-optimized
    /// instance.
    ///
    /// Default: `false`
    ebs_optimized: ?bool = null,

    /// An elastic GPU to associate with the instance.
    ///
    /// **Note:**
    ///
    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    elastic_gpu_specification: ?[]const ElasticGpuSpecification = null,

    /// An elastic inference accelerator to associate with the instance.
    ///
    /// **Note:**
    ///
    /// Amazon Elastic Inference is no longer available.
    elastic_inference_accelerators: ?[]const ElasticInferenceAccelerator = null,

    /// If you’re launching an instance into a dual-stack or IPv6-only subnet, you
    /// can enable
    /// assigning a primary IPv6 address. A primary IPv6 address is an IPv6 GUA
    /// address
    /// associated with an ENI that you have enabled to use a primary IPv6 address.
    /// Use this
    /// option if an instance relies on its IPv6 address not changing. When you
    /// launch the
    /// instance, Amazon Web Services will automatically assign an IPv6 address
    /// associated with
    /// the ENI attached to your instance to be the primary IPv6 address. Once you
    /// enable an
    /// IPv6 GUA address to be a primary IPv6, you cannot disable it. When you
    /// enable an IPv6
    /// GUA address to be a primary IPv6, the first IPv6 GUA will be made the
    /// primary IPv6
    /// address until the instance is terminated or the network interface is
    /// detached. If you
    /// have multiple IPv6 addresses associated with an ENI attached to your
    /// instance and you
    /// enable a primary IPv6 address, the first IPv6 GUA address associated with
    /// the ENI
    /// becomes the primary IPv6 address.
    enable_primary_ipv_6: ?bool = null,

    /// Indicates whether the instance is enabled for Amazon Web Services Nitro
    /// Enclaves. For
    /// more information, see [Amazon Web Services Nitro
    /// Enclaves User Guide](https://docs.aws.amazon.com/enclaves/latest/user/).
    ///
    /// You can't enable Amazon Web Services Nitro Enclaves and hibernation on the
    /// same
    /// instance.
    enclave_options: ?EnclaveOptionsRequest = null,

    /// Indicates whether an instance is enabled for hibernation. This parameter is
    /// valid only
    /// if the instance meets the [hibernation
    /// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). For more information, see [Hibernate your Amazon EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
    ///
    /// You can't enable hibernation and Amazon Web Services Nitro Enclaves on the
    /// same
    /// instance.
    hibernation_options: ?HibernationOptionsRequest = null,

    /// The name or Amazon Resource Name (ARN) of an IAM instance
    /// profile.
    iam_instance_profile: ?IamInstanceProfileSpecification = null,

    /// The ID of the AMI. An AMI ID is required to launch an instance and must be
    /// specified
    /// here or in a launch template.
    image_id: ?[]const u8 = null,

    /// Indicates whether an instance stops or terminates when you initiate shutdown
    /// from the
    /// instance (using the operating system command for system shutdown).
    ///
    /// Default: `stop`
    instance_initiated_shutdown_behavior: ?ShutdownBehavior = null,

    /// The market (purchasing) option for the instances.
    ///
    /// For RunInstances, persistent Spot Instance requests are
    /// only supported when **InstanceInterruptionBehavior** is set
    /// to either `hibernate` or `stop`.
    instance_market_options: ?InstanceMarketOptionsRequest = null,

    /// The instance type. For more information, see [Amazon EC2 Instance
    /// Types
    /// Guide](https://docs.aws.amazon.com/ec2/latest/instancetypes/instance-types.html).
    instance_type: ?InstanceType = null,

    /// The number of IPv6 addresses to associate with the primary network
    /// interface. Amazon EC2 chooses the IPv6 addresses from the range of your
    /// subnet. You
    /// cannot specify this option and the option to assign specific IPv6 addresses
    /// in the same
    /// request. You can specify this option if you've specified a minimum number of
    /// instances
    /// to launch.
    ///
    /// You cannot specify this option and the network interfaces option in the same
    /// request.
    ipv_6_address_count: ?i32 = null,

    /// The IPv6 addresses from the range of the subnet to associate with the
    /// primary network interface. You cannot specify this option and the option to
    /// assign a
    /// number of IPv6 addresses in the same request. You cannot specify this option
    /// if you've
    /// specified a minimum number of instances to launch.
    ///
    /// You cannot specify this option and the network interfaces option in the same
    /// request.
    ipv_6_addresses: ?[]const InstanceIpv6Address = null,

    /// The ID of the kernel.
    ///
    /// **Important:**
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see
    /// [PV-GRUB](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the
    /// *Amazon EC2 User Guide*.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair. For more information, see [Create a key pair for
    /// your EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html).
    ///
    /// **Important:**
    ///
    /// If you do not specify a key pair, you can't connect to the instance unless
    /// you
    /// choose an AMI that is configured to allow users another way to log in.
    key_name: ?[]const u8 = null,

    /// The launch template. Any additional parameters that you specify for the new
    /// instance
    /// overwrite the corresponding parameters included in the launch template.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The license configurations.
    license_specifications: ?[]const LicenseConfigurationRequest = null,

    /// The maintenance and recovery options for the instance.
    maintenance_options: ?InstanceMaintenanceOptionsRequest = null,

    /// The maximum number of instances to launch. If you specify a value that is
    /// more
    /// capacity than Amazon EC2 can launch in the target Availability Zone, Amazon
    /// EC2
    /// launches the largest possible number of instances above the specified
    /// minimum
    /// count.
    ///
    /// Constraints: Between 1 and the quota for the specified instance type for
    /// your account for this Region.
    /// For more information, see [Amazon EC2 instance type
    /// quotas](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-instance-quotas.html).
    max_count: i32,

    /// The metadata options for the instance. For more information, see [Configure
    /// the Instance Metadata Service
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html).
    metadata_options: ?InstanceMetadataOptionsRequest = null,

    /// The minimum number of instances to launch. If you specify a value that is
    /// more
    /// capacity than Amazon EC2 can provide in the target Availability Zone, Amazon
    /// EC2 does
    /// not launch any instances.
    ///
    /// Constraints: Between 1 and the quota for the specified instance type for
    /// your account for this Region.
    /// For more information, see [Amazon EC2 instance type
    /// quotas](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-instance-quotas.html).
    min_count: i32,

    /// Specifies whether detailed monitoring is enabled for the instance.
    monitoring: ?RunInstancesMonitoringEnabled = null,

    /// The network interfaces to associate with the instance.
    network_interfaces: ?[]const InstanceNetworkInterfaceSpecification = null,

    /// Contains settings for the network performance options for the instance.
    network_performance_options: ?InstanceNetworkPerformanceOptionsRequest = null,

    /// Reserved for internal use.
    operator: ?OperatorRequest = null,

    /// The placement for the instance.
    placement: ?Placement = null,

    /// The options for the instance hostname.
    /// The default values are inherited from the subnet.
    /// Applies only if creating a network interface, not attaching an existing one.
    private_dns_name_options: ?PrivateDnsNameOptionsRequest = null,

    /// The primary IPv4 address. You must specify a value from the IPv4 address
    /// range of the subnet.
    ///
    /// Only one private IP address can be designated as primary. You can't specify
    /// this
    /// option if you've specified the option to designate a private IP address as
    /// the primary
    /// IP address in a network interface specification. You cannot specify this
    /// option if
    /// you're launching more than one instance in the request.
    ///
    /// You cannot specify this option and the network interfaces option in the same
    /// request.
    private_ip_address: ?[]const u8 = null,

    /// The ID of the RAM disk to select. Some kernels require additional drivers at
    /// launch.
    /// Check the kernel requirements for information about whether you need to
    /// specify a RAM
    /// disk. To find kernel requirements, go to the Amazon Web Services Resource
    /// Center and
    /// search for the kernel ID.
    ///
    /// **Important:**
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see
    /// [PV-GRUB](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the
    /// *Amazon EC2 User Guide*.
    ramdisk_id: ?[]const u8 = null,

    /// The IDs of the security groups.
    ///
    /// If you specify a network interface, you must specify any security groups as
    /// part of
    /// the network interface instead of using this parameter.
    security_group_ids: ?[]const []const u8 = null,

    /// [Default VPC] The names of the security groups.
    ///
    /// If you specify a network interface, you must specify any security groups as
    /// part of
    /// the network interface instead of using this parameter.
    ///
    /// Default: Amazon EC2 uses the default security group.
    security_groups: ?[]const []const u8 = null,

    /// The ID of the subnet to launch the instance into.
    ///
    /// If you specify a network interface, you must specify any subnets as part of
    /// the
    /// network interface instead of using this parameter.
    subnet_id: ?[]const u8 = null,

    /// The tags to apply to the resources that are created during instance launch.
    ///
    /// You can specify tags for the following resources only:
    ///
    /// * Instances
    ///
    /// * Volumes
    ///
    /// * Spot Instance requests
    ///
    /// * Network interfaces
    ///
    /// To tag a resource after it has been created, see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,

    /// The user data to make available to the instance. User data must be
    /// base64-encoded.
    /// Depending on the tool or SDK that you're using, the base64-encoding might be
    /// performed for you.
    /// For more information, see [Run commands at launch using instance user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html).
    user_data: ?[]const u8 = null,
};

pub const RunInstancesOutput = struct {
    /// Not supported.
    groups: ?[]const GroupIdentifier = null,

    /// The instances.
    instances: ?[]const Instance = null,

    /// The ID of the Amazon Web Services account that owns the reservation.
    owner_id: ?[]const u8 = null,

    /// The ID of the requester that launched the instances on your behalf (for
    /// example,
    /// Amazon Web Services Management Console or Auto Scaling).
    requester_id: ?[]const u8 = null,

    /// The ID of the reservation.
    reservation_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RunInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RunInstancesInput, options: Options) !RunInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: RunInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RunInstances&Version=2016-11-15");
    if (input.additional_info) |v| {
        try body_buf.appendSlice(alloc, "&AdditionalInfo=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.capacity_reservation_specification) |v| {
        if (v.capacity_reservation_preference) |sv| {
            try body_buf.appendSlice(alloc, "&CapacityReservationSpecification.CapacityReservationPreference=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cpu_options) |v| {
        if (v.amd_sev_snp) |sv| {
            try body_buf.appendSlice(alloc, "&CpuOptions.AmdSevSnp=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.core_count) |sv| {
            try body_buf.appendSlice(alloc, "&CpuOptions.CoreCount=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.threads_per_core) |sv| {
            try body_buf.appendSlice(alloc, "&CpuOptions.ThreadsPerCore=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.credit_specification) |v| {
        try body_buf.appendSlice(alloc, "&CreditSpecification.CpuCredits=");
        try appendUrlEncoded(alloc, &body_buf, v.cpu_credits);
    }
    if (input.disable_api_stop) |v| {
        try body_buf.appendSlice(alloc, "&DisableApiStop=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.disable_api_termination) |v| {
        try body_buf.appendSlice(alloc, "&DisableApiTermination=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ebs_optimized) |v| {
        try body_buf.appendSlice(alloc, "&EbsOptimized=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.elastic_gpu_specification) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticGpuSpecification.item.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, item.@"type");
            }
        }
    }
    if (input.elastic_inference_accelerators) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticInferenceAccelerators.item.{d}.Count=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticInferenceAccelerators.item.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, item.@"type");
            }
        }
    }
    if (input.enable_primary_ipv_6) |v| {
        try body_buf.appendSlice(alloc, "&EnablePrimaryIpv6=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.enclave_options) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&EnclaveOptions.Enabled=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.hibernation_options) |v| {
        if (v.configured) |sv| {
            try body_buf.appendSlice(alloc, "&HibernationOptions.Configured=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.iam_instance_profile) |v| {
        if (v.arn) |sv| {
            try body_buf.appendSlice(alloc, "&IamInstanceProfile.Arn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.name) |sv| {
            try body_buf.appendSlice(alloc, "&IamInstanceProfile.Name=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.image_id) |v| {
        try body_buf.appendSlice(alloc, "&ImageId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_initiated_shutdown_behavior) |v| {
        try body_buf.appendSlice(alloc, "&InstanceInitiatedShutdownBehavior=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_market_options) |v| {
        if (v.market_type) |sv| {
            try body_buf.appendSlice(alloc, "&InstanceMarketOptions.MarketType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(alloc, "&InstanceType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.ipv_6_address_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6AddressCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.Ipv6Address=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.is_primary_ipv_6) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
        }
    }
    if (input.kernel_id) |v| {
        try body_buf.appendSlice(alloc, "&KernelId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.key_name) |v| {
        try body_buf.appendSlice(alloc, "&KeyName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_template) |v| {
        if (v.launch_template_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchTemplate.LaunchTemplateId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.launch_template_name) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchTemplate.LaunchTemplateName=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.version) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchTemplate.Version=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.license_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LicenseSpecifications.item.{d}.LicenseConfigurationArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.license_configuration_arn) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.maintenance_options) |v| {
        if (v.auto_recovery) |sv| {
            try body_buf.appendSlice(alloc, "&MaintenanceOptions.AutoRecovery=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(alloc, "&MaxCount=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.max_count}) catch "");
    if (input.metadata_options) |v| {
        if (v.http_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.http_protocol_ipv_6) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpProtocolIpv6=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.http_put_response_hop_limit) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpPutResponseHopLimit=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.http_tokens) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpTokens=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.instance_metadata_tags) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.InstanceMetadataTags=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(alloc, "&MinCount=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.min_count}) catch "");
    if (input.monitoring) |v| {
        try body_buf.appendSlice(alloc, "&Monitoring.Enabled=");
        try appendUrlEncoded(alloc, &body_buf, if (v.enabled) "true" else "false");
    }
    if (input.network_interfaces) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.AssociateCarrierIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.associate_carrier_ip_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.AssociatePublicIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.associate_public_ip_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.DeleteOnTermination=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.delete_on_termination) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.description) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.DeviceIndex=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_index) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.EnaQueueCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ena_queue_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.InterfaceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.interface_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.Ipv4PrefixCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_4_prefix_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.Ipv6AddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_address_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.Ipv6PrefixCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_prefix_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.NetworkCardIndex=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.network_card_index) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.NetworkInterfaceId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.network_interface_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.PrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.primary_ipv_6) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.PrivateIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.private_ip_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.SecondaryPrivateIpAddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.secondary_private_ip_address_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaces.item.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.subnet_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.network_performance_options) |v| {
        if (v.bandwidth_weighting) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkPerformanceOptions.BandwidthWeighting=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(alloc, "&Operator.Principal=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.placement) |v| {
        if (v.affinity) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.Affinity=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.availability_zone) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.AvailabilityZone=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.availability_zone_id) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.AvailabilityZoneId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.group_id) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.GroupId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.group_name) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.GroupName=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.host_id) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.HostId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.host_resource_group_arn) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.HostResourceGroupArn=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.partition_number) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.PartitionNumber=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.spread_domain) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.SpreadDomain=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.tenancy) |sv| {
            try body_buf.appendSlice(alloc, "&Placement.Tenancy=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.private_dns_name_options) |v| {
        if (v.enable_resource_name_dns_aaaa_record) |sv| {
            try body_buf.appendSlice(alloc, "&PrivateDnsNameOptions.EnableResourceNameDnsAAAARecord=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.enable_resource_name_dns_a_record) |sv| {
            try body_buf.appendSlice(alloc, "&PrivateDnsNameOptions.EnableResourceNameDnsARecord=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.hostname_type) |sv| {
            try body_buf.appendSlice(alloc, "&PrivateDnsNameOptions.HostnameType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&PrivateIpAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ramdisk_id) |v| {
        try body_buf.appendSlice(alloc, "&RamdiskId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.SecurityGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.subnet_id) |v| {
        try body_buf.appendSlice(alloc, "&SubnetId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.user_data) |v| {
        try body_buf.appendSlice(alloc, "&UserData=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RunInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RunInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "groupSet")) {
                    result.groups = try serde.deserializeGroupIdentifierList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "instancesSet")) {
                    result.instances = try serde.deserializeInstanceList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "ownerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "requesterId")) {
                    result.requester_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "reservationId")) {
                    result.reservation_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
