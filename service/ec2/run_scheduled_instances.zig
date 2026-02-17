const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ScheduledInstancesLaunchSpecification = @import("scheduled_instances_launch_specification.zig").ScheduledInstancesLaunchSpecification;
const serde = @import("serde.zig");

pub const RunScheduledInstancesInput = struct {
    /// Unique, case-sensitive identifier that ensures the idempotency of the
    /// request.
    /// For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of instances.
    ///
    /// Default: 1
    instance_count: ?i32 = null,

    /// The launch specification. You must match the instance type, Availability
    /// Zone,
    /// network, and platform of the schedule that you purchased.
    launch_specification: ScheduledInstancesLaunchSpecification,

    /// The Scheduled Instance ID.
    scheduled_instance_id: []const u8,
};

pub const RunScheduledInstancesOutput = struct {
    /// The IDs of the newly launched instances.
    instance_id_set: ?[]const []const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RunScheduledInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RunScheduledInstancesInput, options: Options) !RunScheduledInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RunScheduledInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RunScheduledInstances&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(alloc, "&InstanceCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.launch_specification.block_device_mappings) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.encrypted) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Iops=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.iops) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.snapshot_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_size) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_type) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.launch_specification.ebs_optimized) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.EbsOptimized=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_specification.iam_instance_profile) |sv| {
        if (sv.arn) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.IamInstanceProfile.Arn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.name) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.IamInstanceProfile.Name=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    try body_buf.appendSlice(alloc, "&LaunchSpecification.ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.launch_specification.image_id);
    if (input.launch_specification.instance_type) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.InstanceType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_specification.kernel_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.KernelId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_specification.key_name) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.KeyName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_specification.monitoring) |sv| {
        if (sv.enabled) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Monitoring.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
    }
    if (input.launch_specification.network_interfaces) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.AssociatePublicIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.associate_public_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.DeleteOnTermination=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.delete_on_termination) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.description) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.DeviceIndex=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_index) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.groups) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.Groups.SecurityGroupId.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.Ipv6AddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_address_count) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ipv_6_addresses) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.Ipv6Addresses.Ipv6Address.{d}.Ipv6Address=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_6_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.NetworkInterfaceId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.network_interface_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.PrivateIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.private_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.private_ip_address_configs) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.PrivateIpAddressConfigs.PrivateIpAddressConfigSet.{d}.Primary=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.primary) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.PrivateIpAddressConfigs.PrivateIpAddressConfigSet.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.private_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.SecondaryPrivateIpAddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.secondary_private_ip_address_count) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.NetworkInterface.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.subnet_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.launch_specification.placement) |sv| {
        if (sv.availability_zone) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.AvailabilityZone=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.group_name) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.GroupName=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.launch_specification.ramdisk_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.RamdiskId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_specification.security_group_ids) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.launch_specification.subnet_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.SubnetId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_specification.user_data) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchSpecification.UserData=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&ScheduledInstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.scheduled_instance_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RunScheduledInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RunScheduledInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceIdSet")) {
                    result.instance_id_set = try serde.deserializeInstanceIdSet(&reader, alloc, "item");
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
