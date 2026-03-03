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
    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    elastic_gpu_specification: ?[]const ElasticGpuSpecification = null,

    /// An elastic inference accelerator to associate with the instance.
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
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see
    /// [PV-GRUB](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the
    /// *Amazon EC2 User Guide*.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair. For more information, see [Create a key pair for
    /// your EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html).
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

const RunInstancesOutput = @import("reservation.zig").Reservation;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RunInstancesInput, options: Options) !RunInstancesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RunInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=RunInstances&Version=2016-11-15");
    if (input.additional_info) |v| {
        try body_buf.appendSlice(allocator, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.AvailabilityZone=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.availability_zone) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.AvailabilityZoneId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.availability_zone_id) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.EbsCardIndex=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.ebs_card_index) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.encrypted) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Iops=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.iops) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.kms_key_id) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.OutpostArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.outpost_arn) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.snapshot_id) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.throughput) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeInitializationRate=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.volume_initialization_rate) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.volume_size) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.volume_type) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_2));
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.capacity_reservation_specification) |v| {
        if (v.capacity_reservation_preference) |sv| {
            try body_buf.appendSlice(allocator, "&CapacityReservationSpecification.CapacityReservationPreference=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.capacity_reservation_target) |sv| {
            if (sv.capacity_reservation_id) |sv2| {
                try body_buf.appendSlice(allocator, "&CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationId=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.capacity_reservation_resource_group_arn) |sv2| {
                try body_buf.appendSlice(allocator, "&CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationResourceGroupArn=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cpu_options) |v| {
        if (v.amd_sev_snp) |sv| {
            try body_buf.appendSlice(allocator, "&CpuOptions.AmdSevSnp=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.core_count) |sv| {
            try body_buf.appendSlice(allocator, "&CpuOptions.CoreCount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.threads_per_core) |sv| {
            try body_buf.appendSlice(allocator, "&CpuOptions.ThreadsPerCore=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.credit_specification) |v| {
        try body_buf.appendSlice(allocator, "&CreditSpecification.CpuCredits=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.cpu_credits);
    }
    if (input.disable_api_stop) |v| {
        try body_buf.appendSlice(allocator, "&DisableApiStop=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.disable_api_termination) |v| {
        try body_buf.appendSlice(allocator, "&DisableApiTermination=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ebs_optimized) |v| {
        try body_buf.appendSlice(allocator, "&EbsOptimized=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.elastic_gpu_specification) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticGpuSpecification.item.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.@"type");
            }
        }
    }
    if (input.elastic_inference_accelerators) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticInferenceAccelerator.item.{d}.Count=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ElasticInferenceAccelerator.item.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.@"type");
            }
        }
    }
    if (input.enable_primary_ipv_6) |v| {
        try body_buf.appendSlice(allocator, "&EnablePrimaryIpv6=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enclave_options) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(allocator, "&EnclaveOptions.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.hibernation_options) |v| {
        if (v.configured) |sv| {
            try body_buf.appendSlice(allocator, "&HibernationOptions.Configured=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.iam_instance_profile) |v| {
        if (v.arn) |sv| {
            try body_buf.appendSlice(allocator, "&IamInstanceProfile.Arn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.name) |sv| {
            try body_buf.appendSlice(allocator, "&IamInstanceProfile.Name=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.image_id) |v| {
        try body_buf.appendSlice(allocator, "&ImageId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_initiated_shutdown_behavior) |v| {
        try body_buf.appendSlice(allocator, "&InstanceInitiatedShutdownBehavior=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.instance_market_options) |v| {
        if (v.market_type) |sv| {
            try body_buf.appendSlice(allocator, "&InstanceMarketOptions.MarketType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.spot_options) |sv| {
            if (sv.block_duration_minutes) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceMarketOptions.SpotOptions.BlockDurationMinutes=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.instance_interruption_behavior) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceMarketOptions.SpotOptions.InstanceInterruptionBehavior=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv2));
            }
            if (sv.max_price) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceMarketOptions.SpotOptions.MaxPrice=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.spot_instance_type) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceMarketOptions.SpotOptions.SpotInstanceType=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv2));
            }
            if (sv.valid_until) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceMarketOptions.SpotOptions.ValidUntil=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(allocator, "&InstanceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.ipv_6_address_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6AddressCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Address.item.{d}.Ipv6Address=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Address.item.{d}.IsPrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.is_primary_ipv_6) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.kernel_id) |v| {
        try body_buf.appendSlice(allocator, "&KernelId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.key_name) |v| {
        try body_buf.appendSlice(allocator, "&KeyName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.launch_template) |v| {
        if (v.launch_template_id) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.LaunchTemplateId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.launch_template_name) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.LaunchTemplateName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.version) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchTemplate.Version=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.license_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LicenseSpecification.item.{d}.LicenseConfigurationArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.license_configuration_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.maintenance_options) |v| {
        if (v.auto_recovery) |sv| {
            try body_buf.appendSlice(allocator, "&MaintenanceOptions.AutoRecovery=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(allocator, "&MaxCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.max_count}) catch "");
    if (input.metadata_options) |v| {
        if (v.http_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&MetadataOptions.HttpEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.http_protocol_ipv_6) |sv| {
            try body_buf.appendSlice(allocator, "&MetadataOptions.HttpProtocolIpv6=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.http_put_response_hop_limit) |sv| {
            try body_buf.appendSlice(allocator, "&MetadataOptions.HttpPutResponseHopLimit=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.http_tokens) |sv| {
            try body_buf.appendSlice(allocator, "&MetadataOptions.HttpTokens=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.instance_metadata_tags) |sv| {
            try body_buf.appendSlice(allocator, "&MetadataOptions.InstanceMetadataTags=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(allocator, "&MinCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.min_count}) catch "");
    if (input.monitoring) |v| {
        try body_buf.appendSlice(allocator, "&Monitoring.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v.enabled) "true" else "false");
    }
    if (input.network_interfaces) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.AssociateCarrierIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.associate_carrier_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.AssociatePublicIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.associate_public_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            if (item.connection_tracking_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.ConnectionTrackingSpecification.TcpEstablishedTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.tcp_established_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.ConnectionTrackingSpecification.UdpStreamTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.udp_stream_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.ConnectionTrackingSpecification.UdpTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.udp_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.DeleteOnTermination=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.delete_on_termination) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.description) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.DeviceIndex=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.device_index) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.EnaQueueCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ena_queue_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ena_srd_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.EnaSrdSpecification.EnaSrdEnabled=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (sv_1.ena_srd_enabled) |fv_2| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                if (sv_1.ena_srd_udp_specification) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_2.ena_srd_udp_enabled) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                        }
                    }
                }
            }
            if (item.groups) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Groups.SecurityGroupId.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.InterfaceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.interface_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv4PrefixCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_4_prefix_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ipv_4_prefixes) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv4Prefixes.item.{d}.Ipv4Prefix=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.ipv_4_prefix) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv6AddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6_address_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ipv_6_addresses) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv6Addresses.item.{d}.Ipv6Address=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.ipv_6_address) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.is_primary_ipv_6) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv6PrefixCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6_prefix_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ipv_6_prefixes) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.Ipv6Prefixes.item.{d}.Ipv6Prefix=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.ipv_6_prefix) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.NetworkCardIndex=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.network_card_index) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.NetworkInterfaceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.network_interface_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.PrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.primary_ipv_6) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.PrivateIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.private_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.private_ip_addresses) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.PrivateIpAddresses.item.{d}.Primary=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.primary) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.private_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.SecondaryPrivateIpAddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.secondary_private_ip_address_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterface.item.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.subnet_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.network_performance_options) |v| {
        if (v.bandwidth_weighting) |sv| {
            try body_buf.appendSlice(allocator, "&NetworkPerformanceOptions.BandwidthWeighting=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(allocator, "&Operator.Principal=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.placement) |v| {
        if (v.affinity) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.Affinity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.availability_zone) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.AvailabilityZone=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.availability_zone_id) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.AvailabilityZoneId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.group_id) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.GroupId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.group_name) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.GroupName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.host_id) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.HostId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.host_resource_group_arn) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.HostResourceGroupArn=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.partition_number) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.PartitionNumber=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.spread_domain) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.SpreadDomain=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.tenancy) |sv| {
            try body_buf.appendSlice(allocator, "&Placement.Tenancy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.private_dns_name_options) |v| {
        if (v.enable_resource_name_dns_aaaa_record) |sv| {
            try body_buf.appendSlice(allocator, "&PrivateDnsNameOptions.EnableResourceNameDnsAAAARecord=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.enable_resource_name_dns_a_record) |sv| {
            try body_buf.appendSlice(allocator, "&PrivateDnsNameOptions.EnableResourceNameDnsARecord=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.hostname_type) |sv| {
            try body_buf.appendSlice(allocator, "&PrivateDnsNameOptions.HostnameType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(allocator, "&PrivateIpAddress=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ramdisk_id) |v| {
        try body_buf.appendSlice(allocator, "&RamdiskId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupId.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroup.SecurityGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.subnet_id) |v| {
        try body_buf.appendSlice(allocator, "&SubnetId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.user_data) |v| {
        try body_buf.appendSlice(allocator, "&UserData=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RunInstancesOutput {
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
                    result.groups = try serde.deserializeGroupIdentifierList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "instancesSet")) {
                    result.instances = try serde.deserializeInstanceList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "ownerId")) {
                    result.owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "requesterId")) {
                    result.requester_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "reservationId")) {
                    result.reservation_id = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
