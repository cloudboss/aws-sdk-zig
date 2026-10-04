const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineBlueprint = @import("pipeline_blueprint.zig").PipelineBlueprint;

pub const GetPipelineBlueprintInput = struct {
    /// The name of the blueprint to retrieve.
    blueprint_name: []const u8,

    /// The format format of the blueprint to retrieve.
    format: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_name = "BlueprintName",
        .format = "Format",
    };
};

pub const GetPipelineBlueprintOutput = struct {
    /// The requested blueprint in YAML format.
    blueprint: ?PipelineBlueprint = null,

    /// The format of the blueprint.
    format: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint = "Blueprint",
        .format = "Format",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPipelineBlueprintInput, options: CallOptions) !GetPipelineBlueprintOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "osis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPipelineBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2022-01-01/osis/getPipelineBlueprint/");
    try path_buf.appendSlice(allocator, input.blueprint_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.format) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "format=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPipelineBlueprintOutput {
    var result: GetPipelineBlueprintOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPipelineBlueprintOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
