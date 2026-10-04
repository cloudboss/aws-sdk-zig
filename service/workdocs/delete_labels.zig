const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteLabelsInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// Flag to request removal of all labels from the specified resource.
    delete_all: ?bool = null,

    /// List of labels to delete from the resource.
    labels: ?[]const []const u8 = null,

    /// The ID of the resource.
    resource_id: []const u8,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .delete_all = "DeleteAll",
        .labels = "Labels",
        .resource_id = "ResourceId",
    };
};

pub const DeleteLabelsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLabelsInput, options: CallOptions) !DeleteLabelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLabelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/labels");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.delete_all) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deleteAll=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.labels) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "labels=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLabelsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteLabelsOutput = .{};

    return result;
}
