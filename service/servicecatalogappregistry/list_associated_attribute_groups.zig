const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAssociatedAttributeGroupsInput = struct {
    /// The name or ID of the application.
    application: []const u8,

    /// The upper bound of the number of results to return (cannot exceed 25). If
    /// this parameter is omitted, it defaults to 25. This value is optional.
    max_results: ?i32 = null,

    /// The token to use to get the next page of results after a previous API call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application = "application",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAssociatedAttributeGroupsOutput = struct {
    /// A list of attribute group IDs.
    attribute_groups: ?[]const []const u8 = null,

    /// The token to use to get the next page of results after a previous API call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_groups = "attributeGroups",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssociatedAttributeGroupsInput, options: CallOptions) !ListAssociatedAttributeGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssociatedAttributeGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog-appregistry", "Service Catalog AppRegistry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application);
    try path_buf.appendSlice(allocator, "/attribute-groups");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssociatedAttributeGroupsOutput {
    var result: ListAssociatedAttributeGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAssociatedAttributeGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
