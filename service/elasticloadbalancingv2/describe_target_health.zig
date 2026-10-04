const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeTargetHealthInputIncludeEnum = @import("describe_target_health_input_include_enum.zig").DescribeTargetHealthInputIncludeEnum;
const TargetDescription = @import("target_description.zig").TargetDescription;
const TargetHealthDescription = @import("target_health_description.zig").TargetHealthDescription;
const serde = @import("serde.zig");

pub const DescribeTargetHealthInput = struct {
    /// Used to include anomaly detection information.
    include: ?[]const DescribeTargetHealthInputIncludeEnum = null,

    /// The Amazon Resource Name (ARN) of the target group.
    target_group_arn: []const u8,

    /// The targets.
    targets: ?[]const TargetDescription = null,
};

pub const DescribeTargetHealthOutput = struct {
    /// Information about the health of the targets.
    target_health_descriptions: ?[]const TargetHealthDescription = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTargetHealthInput, options: CallOptions) !DescribeTargetHealthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTargetHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeTargetHealth&Version=2015-12-01");
    if (input.include) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Include.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    try body_buf.appendSlice(allocator, "&TargetGroupArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_group_arn);
    if (input.targets) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.availability_zone) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Targets.member.{d}.AvailabilityZone=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Targets.member.{d}.Id=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.port) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Targets.member.{d}.Port=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.quic_server_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Targets.member.{d}.QuicServerId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTargetHealthOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeTargetHealthResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeTargetHealthOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TargetHealthDescriptions")) {
                    result.target_health_descriptions = try serde.deserializeTargetHealthDescriptions(allocator, &reader, "member");
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
