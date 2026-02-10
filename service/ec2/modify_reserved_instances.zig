const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReservedInstancesConfiguration = @import("reserved_instances_configuration.zig").ReservedInstancesConfiguration;

/// Modifies the configuration of your Reserved Instances, such as the
/// Availability Zone,
/// instance count, or instance type. The Reserved Instances to be modified must
/// be identical,
/// except for Availability Zone, network platform, and instance type.
///
/// For more information, see [Modify Reserved
/// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html) in the
/// *Amazon EC2 User Guide*.
pub const ModifyReservedInstancesInput = struct {
    /// A unique, case-sensitive token you provide to ensure idempotency of your
    /// modification
    /// request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The IDs of the Reserved Instances to modify.
    reserved_instances_ids: []const []const u8,

    /// The configuration settings for the Reserved Instances to modify.
    target_configurations: []const ReservedInstancesConfiguration,
};

pub const ModifyReservedInstancesOutput = struct {
    /// The ID for the modification.
    reserved_instances_modification_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyReservedInstancesOutput) void {
        if (self.reserved_instances_modification_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyReservedInstancesInput, options: Options) !ModifyReservedInstancesOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyReservedInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyReservedInstances&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    for (input.reserved_instances_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReservedInstancesIds.ReservedInstancesId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    for (input.target_configurations, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.AvailabilityZone=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.availability_zone) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.AvailabilityZoneId=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.availability_zone_id) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.InstanceCount=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.instance_count) |v| {
                try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.InstanceType=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.instance_type) |v| {
                try appendUrlEncoded(alloc, &body_buf, @tagName(v));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.Platform=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.platform) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.item.{d}.Scope=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.scope) |v| {
                try appendUrlEncoded(alloc, &body_buf, @tagName(v));
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyReservedInstancesOutput {
    _ = status;
    var result: ModifyReservedInstancesOutput = .{ .allocator = alloc };
    if (findElement(body, "reservedInstancesModificationId")) |content| {
        result.reserved_instances_modification_id = try alloc.dupe(u8, content);
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
