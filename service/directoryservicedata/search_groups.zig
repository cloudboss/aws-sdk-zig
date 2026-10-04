const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Group = @import("group.zig").Group;

pub const SearchGroupsInput = struct {
    /// The identifier (ID) of the directory that's associated with the group.
    directory_id: []const u8,

    /// The maximum number of results to be returned per request.
    max_results: ?i32 = null,

    /// An encoded paging token for paginated calls that can be passed back to
    /// retrieve the next
    /// page.
    next_token: ?[]const u8 = null,

    /// The domain name that's associated with the group.
    ///
    /// This parameter is optional, so you can return groups outside of your Managed
    /// Microsoft AD
    /// domain. When no value is defined, only your Managed Microsoft AD groups are
    /// returned.
    ///
    /// This value is case insensitive.
    realm: ?[]const u8 = null,

    /// One or more data attributes that are used to search for a group. For a list
    /// of supported
    /// attributes, see [Directory Service Data
    /// Attributes](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ad_data_attributes.html).
    search_attributes: []const []const u8,

    /// The attribute value that you want to search for.
    ///
    /// Wildcard `(*)` searches aren't supported. For a list of supported
    /// attributes, see [Directory Service Data
    /// Attributes](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ad_data_attributes.html).
    search_string: []const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .realm = "Realm",
        .search_attributes = "SearchAttributes",
        .search_string = "SearchString",
    };
};

pub const SearchGroupsOutput = struct {
    /// The identifier (ID) of the directory that's associated with the group.
    directory_id: ?[]const u8 = null,

    /// The group information that the request returns.
    groups: ?[]const Group = null,

    /// An encoded paging token for paginated calls that can be passed back to
    /// retrieve the next
    /// page.
    next_token: ?[]const u8 = null,

    /// The domain that's associated with the group.
    realm: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .groups = "Groups",
        .next_token = "NextToken",
        .realm = "Realm",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchGroupsInput, options: CallOptions) !SearchGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds-data", "Directory Service Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Groups/SearchGroups";

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

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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
    try body_buf.appendSlice(allocator, "\"SearchAttributes\":");
    try aws.json.writeValue(@TypeOf(input.search_attributes), input.search_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SearchString\":");
    try aws.json.writeValue(@TypeOf(input.search_string), input.search_string, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchGroupsOutput {
    var result: SearchGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
