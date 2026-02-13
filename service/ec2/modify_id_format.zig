const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Modifies the ID format for the specified resource on a per-Region basis. You
/// can
/// specify that resources should receive longer IDs (17-character IDs) when
/// they are
/// created.
///
/// This request can only be used to modify longer ID settings for resource
/// types that
/// are within the opt-in period. Resources currently in their opt-in period
/// include:
/// `bundle` | `conversion-task` | `customer-gateway` | `dhcp-options` |
/// `elastic-ip-allocation` | `elastic-ip-association` |
/// `export-task` | `flow-log` | `image` |
/// `import-task` | `internet-gateway` | `network-acl`
/// | `network-acl-association` | `network-interface` |
/// `network-interface-attachment` | `prefix-list` |
/// `route-table` | `route-table-association` |
/// `security-group` | `subnet` |
/// `subnet-cidr-block-association` | `vpc` |
/// `vpc-cidr-block-association` | `vpc-endpoint` | `vpc-peering-connection` |
/// `vpn-connection` | `vpn-gateway`.
///
/// This setting applies to the IAM user who makes the request; it does not
/// apply to the
/// entire Amazon Web Services account. By default, an IAM user defaults to the
/// same settings as the root user. If
/// you're using this action as the root user, then these settings apply to the
/// entire account,
/// unless an IAM user explicitly overrides these settings for themselves. For
/// more information,
/// see [Resource
/// IDs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/resource-ids.html)
/// in the *Amazon Elastic Compute Cloud User Guide*.
///
/// Resources created with longer IDs are visible to all IAM roles and users,
/// regardless
/// of these settings and provided that they have permission to use the relevant
/// `Describe` command for the resource type.
pub const ModifyIdFormatInput = struct {
    /// The type of resource: `bundle` | `conversion-task` | `customer-gateway` |
    /// `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `internet-gateway` | `network-acl`
    /// | `network-acl-association` | `network-interface` |
    /// `network-interface-attachment` | `prefix-list` |
    /// `route-table` | `route-table-association` |
    /// `security-group` | `subnet` |
    /// `subnet-cidr-block-association` | `vpc` |
    /// `vpc-cidr-block-association` | `vpc-endpoint` | `vpc-peering-connection` |
    /// `vpn-connection` | `vpn-gateway`.
    ///
    /// Alternatively, use the `all-current` option to include all resource types
    /// that are
    /// currently within their opt-in period for longer IDs.
    resource: []const u8,

    /// Indicate whether the resource should use longer IDs (17-character IDs).
    use_long_ids: bool,
};

pub const ModifyIdFormatOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyIdFormatOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIdFormatInput, options: Options) !ModifyIdFormatOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIdFormatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIdFormat&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Resource=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.resource);
    try body_buf.appendSlice(alloc, "&UseLongIds=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, if (input.use_long_ids) "true" else "false");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyIdFormatOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyIdFormatOutput = .{};

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
