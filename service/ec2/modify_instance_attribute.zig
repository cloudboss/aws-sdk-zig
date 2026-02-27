const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceAttributeName = @import("instance_attribute_name.zig").InstanceAttributeName;
const InstanceBlockDeviceMappingSpecification = @import("instance_block_device_mapping_specification.zig").InstanceBlockDeviceMappingSpecification;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const BlobAttributeValue = @import("blob_attribute_value.zig").BlobAttributeValue;
const serde = @import("serde.zig");

pub const ModifyInstanceAttributeInput = struct {
    /// The name of the attribute to modify.
    ///
    /// When changing the instance type: If the original instance type is configured
    /// for
    /// configurable bandwidth, and the desired instance type doesn't support
    /// configurable
    /// bandwidth, first set the existing bandwidth configuration to `default`
    /// using the ModifyInstanceNetworkPerformanceOptions
    /// operation.
    ///
    /// You can modify the following attributes only: `disableApiTermination` |
    /// `instanceType` | `kernel` | `ramdisk` |
    /// `instanceInitiatedShutdownBehavior` | `blockDeviceMapping`
    /// | `userData` | `sourceDestCheck` | `groupSet` |
    /// `ebsOptimized` | `sriovNetSupport` |
    /// `enaSupport` | `nvmeSupport` | `disableApiStop`
    /// | `enclaveOptions`
    attribute: ?InstanceAttributeName = null,

    /// Modifies the `DeleteOnTermination` attribute for volumes that are currently
    /// attached. The volume must be owned by the caller. If no value is specified
    /// for
    /// `DeleteOnTermination`, the default is `true` and the volume is
    /// deleted when the instance is terminated. You can't modify the
    /// `DeleteOnTermination`
    /// attribute for volumes that are attached to Amazon Web Services-managed
    /// resources.
    ///
    /// To add instance store volumes to an Amazon EBS-backed instance, you must add
    /// them when
    /// you launch the instance. For more information, see [Update the block device
    /// mapping when launching an
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html#Using_OverridingAMIBDM) in the
    /// *Amazon EC2 User Guide*.
    block_device_mappings: ?[]const InstanceBlockDeviceMappingSpecification = null,

    /// Indicates whether an instance is enabled for stop protection. For more
    /// information,
    /// see [Enable stop
    /// protection for your
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-stop-protection.html).
    disable_api_stop: ?AttributeBooleanValue = null,

    /// Enable or disable termination protection for the instance. If the value is
    /// `true`,
    /// you can't terminate the instance using the Amazon EC2 console, command line
    /// interface, or API.
    /// You can't enable termination protection for Spot Instances.
    disable_api_termination: ?AttributeBooleanValue = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether the instance is optimized for Amazon EBS I/O. This
    /// optimization
    /// provides dedicated throughput to Amazon EBS and an optimized configuration
    /// stack to
    /// provide optimal EBS I/O performance. This optimization isn't available with
    /// all instance
    /// types. Additional usage charges apply when using an EBS Optimized instance.
    ebs_optimized: ?AttributeBooleanValue = null,

    /// Set to `true` to enable enhanced networking with ENA for the
    /// instance.
    ///
    /// This option is supported only for HVM instances. Specifying this option with
    /// a PV
    /// instance can make it unreachable.
    ena_support: ?AttributeBooleanValue = null,

    /// Replaces the security groups of the instance with the specified security
    /// groups.
    /// You must specify the ID of at least one security group, even if it's just
    /// the default
    /// security group for the VPC.
    groups: ?[]const []const u8 = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// Specifies whether an instance stops or terminates when you initiate shutdown
    /// from the
    /// instance (using the operating system command for system shutdown).
    instance_initiated_shutdown_behavior: ?AttributeValue = null,

    /// Changes the instance type to the specified value. For more information, see
    /// [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2 User Guide*. If the instance type is
    /// not valid, the error returned is `InvalidInstanceAttributeValue`.
    instance_type: ?AttributeValue = null,

    /// Changes the instance's kernel to the specified value. We recommend that you
    /// use
    /// PV-GRUB instead of kernels and RAM disks. For more information, see
    /// [PV-GRUB](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html).
    kernel: ?AttributeValue = null,

    /// Changes the instance's RAM disk to the specified value. We recommend that
    /// you use
    /// PV-GRUB instead of kernels and RAM disks. For more information, see
    /// [PV-GRUB](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html).
    ramdisk: ?AttributeValue = null,

    /// Enable or disable source/destination checks, which ensure that the instance
    /// is either
    /// the source or the destination of any traffic that it receives. If the value
    /// is
    /// `true`, source/destination checks are enabled; otherwise, they are
    /// disabled. The default value is `true`. You must disable source/destination
    /// checks if the instance runs services such as network address translation,
    /// routing, or
    /// firewalls.
    source_dest_check: ?AttributeBooleanValue = null,

    /// Set to `simple` to enable enhanced networking with the Intel 82599 Virtual
    /// Function interface for the instance.
    ///
    /// There is no way to disable enhanced networking with the Intel 82599 Virtual
    /// Function
    /// interface at this time.
    ///
    /// This option is supported only for HVM instances. Specifying this option with
    /// a PV
    /// instance can make it unreachable.
    sriov_net_support: ?AttributeValue = null,

    /// Changes the instance's user data to the specified value. User data must be
    /// base64-encoded.
    /// Depending on the tool or SDK that you're using, the base64-encoding might be
    /// performed for you.
    /// For more information, see [Work with instance user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-add-user-data.html).
    user_data: ?BlobAttributeValue = null,

    /// A new value for the attribute. Use only with the `kernel`,
    /// `ramdisk`, `userData`, `disableApiTermination`, or
    /// `instanceInitiatedShutdownBehavior` attribute.
    value: ?[]const u8 = null,
};

const ModifyInstanceAttributeOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyInstanceAttributeInput, options: Options) !ModifyInstanceAttributeOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.item.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.item.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.item.{d}.Ebs.VolumeId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.item.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMapping.item.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.disable_api_stop) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&DisableApiStop.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.disable_api_termination) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&DisableApiTermination.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ebs_optimized) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EbsOptimized.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.ena_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnaSupport.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&GroupId.groupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.instance_initiated_shutdown_behavior) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&InstanceInitiatedShutdownBehavior.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.instance_type) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&InstanceType.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.kernel) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&Kernel.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.ramdisk) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&Ramdisk.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.source_dest_check) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&SourceDestCheck.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.sriov_net_support) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&SriovNetSupport.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.user_data) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&UserData.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.value) |v| {
        try body_buf.appendSlice(alloc, "&Value=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstanceAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyInstanceAttributeOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
