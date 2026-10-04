const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetModelInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The model ID.
    model_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .model_id = "ModelId",
    };
};

pub const GetModelOutput = struct {
    /// The content-type for the model, for example, "application/json".
    content_type: ?[]const u8 = null,

    /// The description of the model.
    description: ?[]const u8 = null,

    /// The model identifier.
    model_id: ?[]const u8 = null,

    /// The name of the model. Must be alphanumeric.
    name: ?[]const u8 = null,

    /// The schema for the model. For application/json models, this should be JSON
    /// schema draft 4 model.
    schema: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .description = "Description",
        .model_id = "ModelId",
        .name = "Name",
        .schema = "Schema",
    };
};

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
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/models/");
    try path_buf.appendSlice(allocator, input.model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelOutput {
    const result: GetModelOutput = try aws.json.parseJsonObject(
        GetModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
