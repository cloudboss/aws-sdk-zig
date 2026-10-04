const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Blueprint = @import("blueprint.zig").Blueprint;

pub const GetBlueprintInput = struct {
    /// Specifies whether or not to include the blueprint in the response.
    include_blueprint: ?bool = null,

    /// Specifies whether or not to include the parameter specification.
    include_parameter_spec: ?bool = null,

    /// The name of the blueprint.
    name: []const u8,

    pub const json_field_names = .{
        .include_blueprint = "IncludeBlueprint",
        .include_parameter_spec = "IncludeParameterSpec",
        .name = "Name",
    };
};

pub const GetBlueprintOutput = struct {
    /// Returns a `Blueprint` object.
    blueprint: ?Blueprint = null,

    pub const json_field_names = .{
        .blueprint = "Blueprint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBlueprintInput, options: CallOptions) !GetBlueprintOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBlueprintInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetBlueprint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBlueprintOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetBlueprintOutput, body, allocator);
}
