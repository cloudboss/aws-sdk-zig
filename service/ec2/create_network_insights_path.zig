const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateNetworkInsightsPathOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateNetworkInsightsPathInput, options: Options) !CreateNetworkInsightsPathOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateNetworkInsightsPathInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateNetworkInsightsPath&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&ClientToken=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.client_token);
    if (input.destination) |v| {
        try body_buf.appendSlice(alloc, "&Destination=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_ip) |v| {
        try body_buf.appendSlice(alloc, "&DestinationIp=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_port) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPort=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filter_at_destination) |v| {
        if (v.destination_address) |sv| {
            try body_buf.appendSlice(alloc, "&FilterAtDestination.DestinationAddress=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.destination_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtDestination.DestinationPortRange.FromPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtDestination.DestinationPortRange.ToPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
        }
        if (v.source_address) |sv| {
            try body_buf.appendSlice(alloc, "&FilterAtDestination.SourceAddress=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.source_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtDestination.SourcePortRange.FromPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtDestination.SourcePortRange.ToPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
        }
    }
    if (input.filter_at_source) |v| {
        if (v.destination_address) |sv| {
            try body_buf.appendSlice(alloc, "&FilterAtSource.DestinationAddress=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.destination_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtSource.DestinationPortRange.FromPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtSource.DestinationPortRange.ToPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
        }
        if (v.source_address) |sv| {
            try body_buf.appendSlice(alloc, "&FilterAtSource.SourceAddress=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.source_port_range) |sv| {
            if (sv.from_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtSource.SourcePortRange.FromPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.to_port) |sv2| {
                try body_buf.appendSlice(alloc, "&FilterAtSource.SourcePortRange.ToPort=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
        }
    }
    try body_buf.appendSlice(alloc, "&Protocol=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.protocol));
    try body_buf.appendSlice(alloc, "&Source=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.source);
    if (input.source_ip) |v| {
        try body_buf.appendSlice(alloc, "&SourceIp=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateNetworkInsightsPathOutput {
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
                    result.network_insights_path = try serde.deserializeNetworkInsightsPath(&reader, alloc);
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
