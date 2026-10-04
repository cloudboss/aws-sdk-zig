const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineBlueprintSummary = @import("pipeline_blueprint_summary.zig").PipelineBlueprintSummary;

pub const ListPipelineBlueprintsInput = struct {
};

pub const ListPipelineBlueprintsOutput = struct {
    /// A list of available blueprints for Data Prepper.
    blueprints: ?[]const PipelineBlueprintSummary = null,

    pub const json_field_names = .{
        .blueprints = "Blueprints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineBlueprintsInput, options: CallOptions) !ListPipelineBlueprintsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineBlueprintsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2022-01-01/osis/listPipelineBlueprints";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineBlueprintsOutput {
    var result: ListPipelineBlueprintsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPipelineBlueprintsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
