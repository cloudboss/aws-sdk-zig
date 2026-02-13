const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IdFormat = @import("id_format.zig").IdFormat;
const serde = @import("serde.zig");

/// Describes the longer ID format settings for all resource types in a specific
/// Region. This request is useful for performing a quick audit to determine
/// whether a
/// specific Region is fully opted in for longer IDs (17-character IDs).
///
/// This request only returns information about resource types that support
/// longer IDs.
///
/// The following resource types support longer IDs: `bundle` |
/// `conversion-task` | `customer-gateway` | `dhcp-options` |
/// `elastic-ip-allocation` | `elastic-ip-association` |
/// `export-task` | `flow-log` | `image` |
/// `import-task` | `instance` | `internet-gateway` |
/// `network-acl` | `network-acl-association` |
/// `network-interface` | `network-interface-attachment` |
/// `prefix-list` | `reservation` | `route-table` |
/// `route-table-association` | `security-group` |
/// `snapshot` | `subnet` |
/// `subnet-cidr-block-association` | `volume` | `vpc` |
/// `vpc-cidr-block-association` | `vpc-endpoint` |
/// `vpc-peering-connection` | `vpn-connection` | `vpn-gateway`.
pub const DescribeAggregateIdFormatInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,
};

pub const DescribeAggregateIdFormatOutput = struct {
    /// Information about each resource's ID format.
    statuses: ?[]const IdFormat = null,

    /// Indicates whether all resource types in the Region are configured to use
    /// longer IDs.
    /// This value is only `true` if all users are configured to use longer IDs for
    /// all resources types in the Region.
    use_long_ids_aggregated: ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeAggregateIdFormatOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeAggregateIdFormatInput, options: Options) !DescribeAggregateIdFormatOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeAggregateIdFormatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeAggregateIdFormat&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeAggregateIdFormatOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeAggregateIdFormatOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "statusSet")) {
                    result.statuses = try serde.deserializeIdFormatList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "useLongIdsAggregated")) {
                    result.use_long_ids_aggregated = std.mem.eql(u8, try reader.readElementText(), "true");
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
