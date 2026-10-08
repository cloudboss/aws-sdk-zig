const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficSourceIdentifier = @import("traffic_source_identifier.zig").TrafficSourceIdentifier;
const serde = @import("serde.zig");

pub const AttachTrafficSourcesInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// If you enable zonal shift with cross-zone disabled load balancers, capacity
    /// could become imbalanced across Availability Zones. To skip the validation,
    /// specify `true`. For more information, see
    /// [Auto Scaling group zonal
    /// shift](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-zonal-shift.html) in the *Amazon EC2 Auto Scaling User Guide*.
    skip_zonal_shift_validation: ?bool = null,

    /// The unique identifiers of one or more traffic sources. You can specify up to
    /// 10
    /// traffic sources.
    traffic_sources: []const TrafficSourceIdentifier,
};

pub const AttachTrafficSourcesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachTrafficSourcesInput, options: CallOptions) !AttachTrafficSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachTrafficSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AttachTrafficSources&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.skip_zonal_shift_validation) |v| {
        try body_buf.appendSlice(allocator, "&SkipZonalShiftValidation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    for (input.traffic_sources, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TrafficSources.member.{d}.Identifier=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.identifier);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.type) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TrafficSources.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachTrafficSourcesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: AttachTrafficSourcesOutput = .{};

    return result;
}
