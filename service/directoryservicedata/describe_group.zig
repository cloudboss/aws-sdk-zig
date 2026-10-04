const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupScope = @import("group_scope.zig").GroupScope;
const GroupType = @import("group_type.zig").GroupType;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

pub const DescribeGroupInput = struct {
    /// The Identifier (ID) of the directory associated with the group.
    directory_id: []const u8,

    /// One or more attributes to be returned for the group. For a list of supported
    /// attributes,
    /// see [Directory Service Data
    /// Attributes](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ad_data_attributes.html).
    other_attributes: ?[]const []const u8 = null,

    /// The domain name that's associated with the group.
    ///
    /// This parameter is optional, so you can return groups outside of your Managed
    /// Microsoft AD
    /// domain. When no value is defined, only your Managed Microsoft AD groups are
    /// returned.
    ///
    /// This value is case insensitive.
    realm: ?[]const u8 = null,

    /// The name of the group.
    sam_account_name: []const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .other_attributes = "OtherAttributes",
        .realm = "Realm",
        .sam_account_name = "SAMAccountName",
    };
};

pub const DescribeGroupOutput = struct {
    /// The identifier (ID) of the directory that's associated with the group.
    directory_id: ?[]const u8 = null,

    /// The [distinguished
    /// name](https://learn.microsoft.com/en-us/windows/win32/ad/object-names-and-identities#distinguished-name) of the object.
    distinguished_name: ?[]const u8 = null,

    /// The scope of the AD group. For details, see [Active Directory security
    /// groups](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
    group_scope: ?GroupScope = null,

    /// The AD group type. For details, see [Active Directory security group
    /// type](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#how-active-directory-security-groups-work).
    group_type: ?GroupType = null,

    /// The attribute values that are returned for the attribute names that are
    /// included in the
    /// request.
    other_attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The domain name that's associated with the group.
    realm: ?[]const u8 = null,

    /// The name of the group.
    sam_account_name: ?[]const u8 = null,

    /// The unique security identifier (SID) of the group.
    sid: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .distinguished_name = "DistinguishedName",
        .group_scope = "GroupScope",
        .group_type = "GroupType",
        .other_attributes = "OtherAttributes",
        .realm = "Realm",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGroupInput, options: CallOptions) !DescribeGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds-data", "Directory Service Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Groups/DescribeGroup";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGroupOutput {
    const result: DescribeGroupOutput = try aws.json.parseJsonObject(
        DescribeGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
