const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Modifies the ID format of a resource for a specified IAM user, IAM role, or
/// the root
/// user for an account; or all IAM users, IAM roles, and the root user for an
/// account. You can
/// specify that resources should receive longer IDs (17-character IDs) when
/// they are created.
///
/// This request can only be used to modify longer ID settings for resource
/// types that are
/// within the opt-in period. Resources currently in their opt-in period
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
/// For more information, see [Resource
/// IDs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/resource-ids.html)
/// in the
/// *Amazon Elastic Compute Cloud User Guide*.
///
/// This setting applies to the principal specified in the request; it does not
/// apply to the
/// principal that makes the request.
///
/// Resources created with longer IDs are visible to all IAM roles and users,
/// regardless of these
/// settings and provided that they have permission to use the relevant
/// `Describe`
/// command for the resource type.
pub const ModifyIdentityIdFormatInput = struct {
    /// The ARN of the principal, which can be an IAM user, IAM role, or the root
    /// user. Specify
    /// `all` to modify the ID format for all IAM users, IAM roles, and the root
    /// user of
    /// the account.
    principal_arn: []const u8,

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

    /// Indicates whether the resource should use longer IDs (17-character IDs)
    use_long_ids: bool,
};

pub const ModifyIdentityIdFormatOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyIdentityIdFormatOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIdentityIdFormatInput, options: Options) !ModifyIdentityIdFormatOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIdentityIdFormatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIdentityIdFormat&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&PrincipalArn=");
    try appendUrlEncoded(alloc, &body_buf, input.principal_arn);
    try body_buf.appendSlice(alloc, "&Resource=");
    try appendUrlEncoded(alloc, &body_buf, input.resource);
    try body_buf.appendSlice(alloc, "&UseLongIds=");
    try appendUrlEncoded(alloc, &body_buf, if (input.use_long_ids) "true" else "false");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyIdentityIdFormatOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyIdentityIdFormatOutput = .{};

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
