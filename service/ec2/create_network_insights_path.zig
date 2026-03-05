const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PathRequestFilter = @import("path_request_filter.zig").PathRequestFilter;
const Protocol = @import("protocol.zig").Protocol;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NetworkInsightsPath = @import("network_insights_path.zig").NetworkInsightsPath;
const serde = @import("serde.zig");

pub const CreateNetworkInsightsPathInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information,
    /// see [How to ensure
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: []const u8,

    /// The ID or ARN of the destination. If the resource is in another account, you
    /// must specify an ARN.
    destination: ?[]const u8 = null,

    /// The IP address of the destination.
    destination_ip: ?[]const u8 = null,

    /// The destination port.
    destination_port: ?i32 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Scopes the analysis to network paths that match specific filters at the
    /// destination. If you specify
    /// this parameter, you can't specify the parameter for the destination IP
    /// address.
    filter_at_destination: ?PathRequestFilter = null,

    /// Scopes the analysis to network paths that match specific filters at the
    /// source. If you specify
    /// this parameter, you can't specify the parameters for the source IP address
    /// or the destination port.
    filter_at_source: ?PathRequestFilter = null,

    /// The protocol.
    protocol: Protocol,

    /// The ID or ARN of the source. If the resource is in another account, you must
    /// specify an ARN.
    source: []const u8,

    /// The IP address of the source.
    source_ip: ?[]const u8 = null,

    /// The tags to add to the path.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateNetworkInsightsPathOutput = struct {
    /// Information about the path.
    network_insights_path: ?NetworkInsightsPath = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkInsightsPathInput, options: CallOptions) !CreateNetworkInsightsPathOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkInsightsPathInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateNetworkInsightsPath&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&ClientToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_token);
    if (input.destination) |v| {
        try body_buf.appendSlice(allocator, "&Destination=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_ip) |v| {
        try body_buf.appendSlice(allocator, "&DestinationIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_port) |v| {
        try body_buf.appendSlice(allocator, "&DestinationPort=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filter_at_destination) |v| {
        if (v.destination_address) |sv| {
            try body_buf.appendSlice(allocator, "&FilterAtDestination.DestinationAddress=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.destination_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtDestination.DestinationPortRange.FromPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtDestination.DestinationPortRange.ToPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
        if (v.source_address) |sv| {
            try body_buf.appendSlice(allocator, "&FilterAtDestination.SourceAddress=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.source_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtDestination.SourcePortRange.FromPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtDestination.SourcePortRange.ToPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
    }
    if (input.filter_at_source) |v| {
        if (v.destination_address) |sv| {
            try body_buf.appendSlice(allocator, "&FilterAtSource.DestinationAddress=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.destination_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtSource.DestinationPortRange.FromPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtSource.DestinationPortRange.ToPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
        if (v.source_address) |sv| {
            try body_buf.appendSlice(allocator, "&FilterAtSource.SourceAddress=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.source_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtSource.SourcePortRange.FromPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(allocator, "&FilterAtSource.SourcePortRange.ToPort=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
    }
    try body_buf.appendSlice(allocator, "&Protocol=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.protocol.wireName());
    try body_buf.appendSlice(allocator, "&Source=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source);
    if (input.source_ip) |v| {
        try body_buf.appendSlice(allocator, "&SourceIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkInsightsPathOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateNetworkInsightsPathOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "networkInsightsPath")) {
                    result.network_insights_path = try serde.deserializeNetworkInsightsPath(allocator, &reader);
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
