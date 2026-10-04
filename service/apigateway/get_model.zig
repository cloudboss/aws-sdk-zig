const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetModelInput = struct {
    /// A query parameter of a Boolean value to resolve (`true`) all external model
    /// references and returns a flattened model schema or not (`false`) The default
    /// is `false`.
    flatten: ?bool = null,

    /// The name of the model as an identifier.
    model_name: []const u8,

    /// The RestApi identifier under which the Model exists.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .flatten = "flatten",
        .model_name = "modelName",
        .rest_api_id = "restApiId",
    };
};

pub const GetModelOutput = @import("model.zig").Model;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelInput, options: CallOptions) !GetModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/models/");
    try path_buf.appendSlice(allocator, input.model_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.flatten) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "flatten=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelOutput {
    var result: GetModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
