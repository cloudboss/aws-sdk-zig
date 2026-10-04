const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupScope = @import("group_scope.zig").GroupScope;
const GroupType = @import("group_type.zig").GroupType;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const UpdateType = @import("update_type.zig").UpdateType;

pub const UpdateGroupInput = struct {
    /// A unique and case-sensitive identifier that you provide to make sure the
    /// idempotency of
    /// the request, so multiple identical calls have the same effect as one single
    /// call.
    ///
    /// A client token is valid for 8 hours after the first request that uses it
    /// completes. After
    /// 8 hours, any request with the same client token is treated as a new request.
    /// If the request
    /// succeeds, any future uses of that token will be idempotent for another 8
    /// hours.
    ///
    /// If you submit a request with the same client token but change one of the
    /// other parameters
    /// within the 8-hour idempotency window, Directory Service Data returns an
    /// `ConflictException`.
    ///
    /// This parameter is optional when using the CLI or SDK.
    client_token: ?[]const u8 = null,

    /// The identifier (ID) of the directory that's associated with the group.
    directory_id: []const u8,

    /// The scope of the AD group. For details, see [Active Directory security
    /// groups](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
    group_scope: ?GroupScope = null,

    /// The AD group type. For details, see [Active Directory security group
    /// type](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#how-active-directory-security-groups-work).
    group_type: ?GroupType = null,

    /// An expression that defines one or more attributes with the data type and the
    /// value of
    /// each attribute.
    other_attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The name of the group.
    sam_account_name: []const u8,

    /// The type of update to be performed. If no value exists for the attribute,
    /// use
    /// `ADD`. Otherwise, use `REPLACE` to change an attribute value or
    /// `REMOVE` to clear the attribute value.
    update_type: ?UpdateType = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .directory_id = "DirectoryId",
        .group_scope = "GroupScope",
        .group_type = "GroupType",
        .other_attributes = "OtherAttributes",
        .sam_account_name = "SAMAccountName",
        .update_type = "UpdateType",
    };
};

pub const UpdateGroupOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGroupInput, options: CallOptions) !UpdateGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds-data", "Directory Service Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Groups/UpdateGroup";

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

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupScope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.other_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OtherAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SAMAccountName\":");
    try aws.json.writeValue(@TypeOf(input.sam_account_name), input.sam_account_name, allocator, &body_buf);
    has_prev = true;
    if (input.update_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UpdateType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGroupOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateGroupOutput = .{};

    return result;
}
