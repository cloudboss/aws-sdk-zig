const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const InstanceMonitoring = @import("instance_monitoring.zig").InstanceMonitoring;
const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const serde = @import("serde.zig");

pub const CreateLaunchConfigurationInput = struct {
    /// Specifies whether to assign a public IPv4 address to the group's instances.
    /// If the
    /// instance is launched into a default subnet, the default is to assign a
    /// public IPv4
    /// address, unless you disabled the option to assign a public IPv4 address on
    /// the subnet.
    /// If the instance is launched into a nondefault subnet, the default is not to
    /// assign a
    /// public IPv4 address, unless you enabled the option to assign a public IPv4
    /// address on
    /// the subnet.
    ///
    /// If you specify `true`, each instance in the Auto Scaling group receives a
    /// unique
    /// public IPv4 address. For more information, see [Provide network connectivity
    /// for
    /// your Auto Scaling instances using Amazon
    /// VPC](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html)
    /// in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// If you specify this property, you must specify at least one subnet for
    /// `VPCZoneIdentifier` when you create your group.
    associate_public_ip_address: ?bool = null,

    /// The block device mapping entries that define the block devices to attach to
    /// the
    /// instances at launch. By default, the block devices specified in the block
    /// device mapping
    /// for the AMI are used. For more information, see [Block device
    /// mappings](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html) in the *Amazon EC2 User Guide*.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// Available for backward compatibility.
    classic_link_vpc_id: ?[]const u8 = null,

    /// Available for backward compatibility.
    classic_link_vpc_security_groups: ?[]const []const u8 = null,

    /// Specifies whether the launch configuration is optimized for EBS I/O
    /// (`true`) or not (`false`). The optimization provides dedicated
    /// throughput to Amazon EBS and an optimized configuration stack to provide
    /// optimal I/O
    /// performance. This optimization is not available with all instance types.
    /// Additional fees
    /// are incurred when you enable EBS optimization for an instance type that is
    /// not
    /// EBS-optimized by default. For more information, see [Amazon EBS-optimized
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// The default value is `false`.
    ebs_optimized: ?bool = null,

    /// The name or the Amazon Resource Name (ARN) of the instance profile
    /// associated with the
    /// IAM role for the instance. The instance profile contains the IAM role. For
    /// more
    /// information, see [IAM role for applications that run
    /// on Amazon EC2
    /// instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html) in the *Amazon EC2 Auto Scaling User Guide*.
    iam_instance_profile: ?[]const u8 = null,

    /// The ID of the Amazon Machine Image (AMI) that was assigned during
    /// registration. For
    /// more information, see [Find a Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// If you specify `InstanceId`, an `ImageId` is not
    /// required.
    image_id: ?[]const u8 = null,

    /// The ID of the instance to use to create the launch configuration. The new
    /// launch
    /// configuration derives attributes from the instance, except for the block
    /// device
    /// mapping.
    ///
    /// To create a launch configuration with a block device mapping or override any
    /// other
    /// instance attributes, specify them as part of the same request.
    ///
    /// For more information, see [Create a launch
    /// configuration](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html) in the *Amazon EC2 Auto Scaling User Guide*.
    instance_id: ?[]const u8 = null,

    /// Controls whether instances in this group are launched with detailed
    /// (`true`) or basic (`false`) monitoring.
    ///
    /// The default value is `true` (enabled).
    ///
    /// When detailed monitoring is enabled, Amazon CloudWatch generates metrics
    /// every minute and
    /// your account is charged a fee. When you disable detailed monitoring,
    /// CloudWatch generates
    /// metrics every 5 minutes. For more information, see [Configure
    /// monitoring for Auto Scaling
    /// instances](https://docs.aws.amazon.com/autoscaling/latest/userguide/enable-as-instance-metrics.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    instance_monitoring: ?InstanceMonitoring = null,

    /// Specifies the instance type of the EC2 instance. For information about
    /// available
    /// instance types, see [Available
    /// instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes) in the *Amazon EC2 User Guide*.
    ///
    /// If you specify `InstanceId`, an `InstanceType` is not
    /// required.
    instance_type: ?[]const u8 = null,

    /// The ID of the kernel associated with the AMI.
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see [User provided
    /// kernels](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html) in the *Amazon EC2 User Guide*.
    kernel_id: ?[]const u8 = null,

    /// The name of the key pair. For more information, see [Amazon EC2 key pairs
    /// and Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) in the *Amazon EC2 User Guide*.
    key_name: ?[]const u8 = null,

    /// The name of the launch configuration. This name must be unique per Region
    /// per
    /// account.
    launch_configuration_name: []const u8,

    /// The metadata options for the instances. For more information, see [Configure
    /// the instance metadata
    /// options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html#launch-configurations-imds) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    metadata_options: ?InstanceMetadataOptions = null,

    /// The tenancy of the instance, either `default` or `dedicated`. An
    /// instance with `dedicated` tenancy runs on isolated, single-tenant hardware
    /// and can only be launched into a VPC. To launch dedicated instances into a
    /// shared tenancy
    /// VPC (a VPC with the instance placement tenancy attribute set to `default`),
    /// you must set the value of this property to `dedicated`.
    ///
    /// If you specify `PlacementTenancy`, you must specify at least one subnet for
    /// `VPCZoneIdentifier` when you create your group.
    ///
    /// Valid values: `default` | `dedicated`
    placement_tenancy: ?[]const u8 = null,

    /// The ID of the RAM disk to select.
    ///
    /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For more
    /// information, see [User provided
    /// kernels](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html) in the *Amazon EC2 User Guide*.
    ramdisk_id: ?[]const u8 = null,

    /// A list that contains the security group IDs to assign to the instances in
    /// the Auto Scaling
    /// group. For more information, see [Control traffic to your Amazon Web
    /// Services
    /// resources using security
    /// groups](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html) in the *Amazon Virtual Private
    /// Cloud User Guide*.
    security_groups: ?[]const []const u8 = null,

    /// The maximum hourly price to be paid for any Spot Instance launched to
    /// fulfill the
    /// request. Spot Instances are launched when the price you specify exceeds the
    /// current Spot
    /// price. For more information, see [Request Spot
    /// Instances for fault-tolerant and flexible
    /// applications](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-template-spot-instances.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Valid Range: Minimum value of 0.001
    ///
    /// When you change your maximum price by creating a new launch configuration,
    /// running
    /// instances will continue to run as long as the maximum price for those
    /// running
    /// instances is higher than the current Spot price.
    spot_price: ?[]const u8 = null,

    /// The user data to make available to the launched EC2 instances. For more
    /// information,
    /// see [Instance metadata and user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) (Linux) and [Instance metadata and
    /// user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html) (Windows). If you are using a command line tool, base64-encoding
    /// is performed for you, and you can load the text from a file. Otherwise, you
    /// must provide
    /// base64-encoded text. User data is limited to 16 KB.
    user_data: ?[]const u8 = null,
};

const CreateLaunchConfigurationOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLaunchConfigurationInput, options: Options) !CreateLaunchConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscaling");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLaunchConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateLaunchConfiguration&Version=2011-01-01");
    if (input.associate_public_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&AssociatePublicIpAddress=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.device_name);
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.Encrypted=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.encrypted) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.Iops=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.iops) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.snapshot_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.Throughput=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.throughput) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_size) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.Ebs.VolumeType=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_type) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.member.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.classic_link_vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&ClassicLinkVPCId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.classic_link_vpc_security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ClassicLinkVPCSecurityGroups.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.ebs_optimized) |v| {
        try body_buf.appendSlice(alloc, "&EbsOptimized=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.iam_instance_profile) |v| {
        try body_buf.appendSlice(alloc, "&IamInstanceProfile=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.image_id) |v| {
        try body_buf.appendSlice(alloc, "&ImageId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(alloc, "&InstanceId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_monitoring) |v| {
        if (v.enabled) |sv| {
            try body_buf.appendSlice(alloc, "&InstanceMonitoring.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(alloc, "&InstanceType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.kernel_id) |v| {
        try body_buf.appendSlice(alloc, "&KernelId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.key_name) |v| {
        try body_buf.appendSlice(alloc, "&KeyName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&LaunchConfigurationName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.launch_configuration_name);
    if (input.metadata_options) |v| {
        if (v.http_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.http_put_response_hop_limit) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpPutResponseHopLimit=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.http_tokens) |sv| {
            try body_buf.appendSlice(alloc, "&MetadataOptions.HttpTokens=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.placement_tenancy) |v| {
        try body_buf.appendSlice(alloc, "&PlacementTenancy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ramdisk_id) |v| {
        try body_buf.appendSlice(alloc, "&RamdiskId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.spot_price) |v| {
        try body_buf.appendSlice(alloc, "&SpotPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.user_data) |v| {
        try body_buf.appendSlice(alloc, "&UserData=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLaunchConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: CreateLaunchConfigurationOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
