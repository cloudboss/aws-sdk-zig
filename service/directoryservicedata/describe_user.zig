const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds-data", "Directory Service Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Users/DescribeUser";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "DirectoryId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.directory_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
