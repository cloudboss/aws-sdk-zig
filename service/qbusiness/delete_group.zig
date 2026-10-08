const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteGroupInput = struct {
    /// The identifier of the application in which the group mapping belongs.
    application_id: []const u8,

    /// The identifier of the data source linked to the group
    ///
    /// A group can be tied to multiple data sources. You can delete a group from
    /// accessing documents in a certain data source. For example, the groups
    /// "Research", "Engineering", and "Sales and Marketing" are all tied to the
    /// company's documents stored in the data sources Confluence and Salesforce.
    /// You want to delete "Research" and "Engineering" groups from Salesforce, so
    /// that these groups cannot access customer-related documents stored in
    /// Salesforce. Only "Sales and Marketing" should access documents in the
    /// Salesforce data source.
    data_source_id: ?[]const u8 = null,

    /// The name of the group you want to delete.
    group_name: []const u8,

    /// The identifier of the index you want to delete the group from.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .group_name = "groupName",
        .index_id = "indexId",
    };
};

pub const DeleteGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGroupInput, options: CallOptions) !DeleteGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/groups/");
    try path_buf.appendSlice(allocator, input.group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.data_source_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dataSourceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGroupOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteGroupOutput = .{};

    return result;
}
