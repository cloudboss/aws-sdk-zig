const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateContextInput = struct {
    /// The name of the context to update.
    context_name: []const u8,

    /// The new description for the context.
    description: ?[]const u8 = null,

    /// The new list of properties. Overwrites the current property list.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// A list of properties to remove.
    properties_to_remove: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .context_name = "ContextName",
        .description = "Description",
        .properties = "Properties",
        .properties_to_remove = "PropertiesToRemove",
    };
};

pub const UpdateContextOutput = struct {
    /// The Amazon Resource Name (ARN) of the context.
    context_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .context_arn = "ContextArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContextInput, options: CallOptions) !UpdateContextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateContext");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContextOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContextOutput, body, allocator);
}
