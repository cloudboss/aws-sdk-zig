const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompatibilityInformation = @import("compatibility_information.zig").CompatibilityInformation;
const ModelAlias = @import("model_alias.zig").ModelAlias;
const ModelSummary = @import("model_summary.zig").ModelSummary;

pub const ListModelsInput = struct {
    /// The client compatibility version to filter models by compatibility.
    client_compatibility_version: i32,

    pub const json_field_names = .{
        .client_compatibility_version = "clientCompatibilityVersion",
    };
};

pub const ListModelsOutput = struct {
    /// Information about client compatibility and supported models.
    compatibility_information: ?CompatibilityInformation = null,

    /// A list of model aliases that provide stable references to model versions.
    model_aliases: ?[]const ModelAlias = null,

    /// A list of available AI models with their status and compatibility
    /// information.
    model_summaries: ?[]const ModelSummary = null,

    pub const json_field_names = .{
        .compatibility_information = "compatibilityInformation",
        .model_aliases = "modelAliases",
        .model_summaries = "modelSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelsInput, options: CallOptions) !ListModelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "nova-act", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/models";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "clientCompatibilityVersion=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.client_compatibility_version}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelsOutput {
    var result: ListModelsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListModelsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
