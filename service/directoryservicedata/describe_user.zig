const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

pub const DescribeUserInput = struct {
    /// The identifier (ID) of the directory that's associated with the user.
    directory_id: []const u8,

    /// One or more attribute names to be returned for the user. A key is an
    /// attribute name, and
    /// the value is a list of maps. For a list of supported attributes, see
    /// [Directory Service Data
    /// Attributes](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ad_data_attributes.html).
    other_attributes: ?[]const []const u8 = null,

    /// The domain name that's associated with the user.
    ///
    /// This parameter is optional, so you can return users outside your Managed
    /// Microsoft AD domain.
    /// When no value is defined, only your Managed Microsoft AD users are returned.
    ///
    /// This value is case insensitive.
    realm: ?[]const u8 = null,

    /// The name of the user.
    sam_account_name: []const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .other_attributes = "OtherAttributes",
        .realm = "Realm",
        .sam_account_name = "SAMAccountName",
    };
};

pub const DescribeUserOutput = struct {
    /// The identifier (ID) of the directory that's associated with the user.
    directory_id: ?[]const u8 = null,

    /// The [distinguished
    /// name](https://learn.microsoft.com/en-us/windows/win32/ad/object-names-and-identities#distinguished-name) of the object.
    distinguished_name: ?[]const u8 = null,

    /// The email address of the user.
    email_address: ?[]const u8 = null,

    /// Indicates whether the user account is active.
    enabled: ?bool = null,

    /// The first name of the user.
    given_name: ?[]const u8 = null,

    /// The attribute values that are returned for the attribute names that are
    /// included in the
    /// request.
    ///
    /// Attribute names are case insensitive.
    other_attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The domain name that's associated with the user.
    realm: ?[]const u8 = null,

    /// The name of the user.
    sam_account_name: ?[]const u8 = null,

    /// The unique security identifier (SID) of the user.
    sid: ?[]const u8 = null,

    /// The last name of the user.
    surname: ?[]const u8 = null,

    /// The UPN that is an Internet-style login name for a user and is based on the
    /// Internet
    /// standard [RFC 822](https://datatracker.ietf.org/doc/html/rfc822). The UPN is
    /// shorter
    /// than the distinguished name and easier to remember.
    user_principal_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .distinguished_name = "DistinguishedName",
        .email_address = "EmailAddress",
        .enabled = "Enabled",
        .given_name = "GivenName",
        .other_attributes = "OtherAttributes",
        .realm = "Realm",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
        .surname = "Surname",
        .user_principal_name = "UserPrincipalName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserInput, options: CallOptions) !DescribeUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "directoryservicedata");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directoryservicedata", "Directory Service Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/Users/DescribeUser";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "DirectoryId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.directory_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.other_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtherAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.realm) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Realm\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SAMAccountName\":");
    try aws.json.writeValue(@TypeOf(input.sam_account_name), input.sam_account_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserOutput {
    var result: DescribeUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .directory_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
