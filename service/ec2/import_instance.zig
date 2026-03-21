const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DiskImage = @import("disk_image.zig").DiskImage;
const ImportInstanceLaunchSpecification = @import("import_instance_launch_specification.zig").ImportInstanceLaunchSpecification;
const PlatformValues = @import("platform_values.zig").PlatformValues;
const ConversionTask = @import("conversion_task.zig").ConversionTask;
const serde = @import("serde.zig");

pub const ImportInstanceInput = struct {
    /// A description for the instance being imported.
    description: ?[]const u8 = null,

    /// The disk image.
    disk_images: ?[]const DiskImage = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The launch specification.
    launch_specification: ?ImportInstanceLaunchSpecification = null,

    /// The instance operating system.
    platform: PlatformValues,
};

pub const ImportInstanceOutput = struct {
    /// Information about the conversion task.
    conversion_task: ?ConversionTask = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportInstanceInput, options: CallOptions) !ImportInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ImportInstance&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.disk_images) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.description) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImage.{d}.Description=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.image) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImage.{d}.Image.Bytes=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_1.bytes}) catch "");
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImage.{d}.Image.Format=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.format.wireName());
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImage.{d}.Image.ImportManifestUrl=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.import_manifest_url);
                }
            }
            if (item.volume) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DiskImage.{d}.Volume.Size=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_1.size}) catch "");
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_specification) |v| {
        if (v.additional_info) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.AdditionalInfo=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.architecture) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.Architecture=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.group_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.GroupId.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.group_names) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.GroupName.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.instance_initiated_shutdown_behavior) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.InstanceInitiatedShutdownBehavior=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.instance_type) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.InstanceType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.monitoring) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.Monitoring=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.placement) |sv| {
            if (sv.affinity) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.Affinity=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.availability_zone) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.AvailabilityZone=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.availability_zone_id) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.AvailabilityZoneId=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.group_id) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.GroupId=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.group_name) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.GroupName=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.host_id) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.HostId=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.host_resource_group_arn) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.HostResourceGroupArn=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.partition_number) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.PartitionNumber=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.spread_domain) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.SpreadDomain=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
            if (sv.tenancy) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.Placement.Tenancy=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
        }
        if (v.private_ip_address) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.PrivateIpAddress=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.subnet_id) |sv| {
            try body_buf.appendSlice(allocator, "&LaunchSpecification.SubnetId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.user_data) |sv| {
            if (sv.data) |sv2| {
                try body_buf.appendSlice(allocator, "&LaunchSpecification.UserData.Data=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&Platform=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform.wireName());

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ImportInstanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "conversionTask")) {
                    result.conversion_task = try serde.deserializeConversionTask(allocator, &reader);
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
