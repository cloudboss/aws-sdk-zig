const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRegistryInput = struct {
    /// A description of the registry. If description is not provided, there will
    /// not be any default value for this.
    description: ?[]const u8 = null,

    /// Name of the registry to be created of max length of 255, and may only
    /// contain letters, numbers, hyphen, underscore, dollar sign, or hash mark. No
    /// whitespace.
    registry_name: []const u8,

    /// Amazon Web Services tags that contain a key value pair and may be searched
    /// by console, command line, or API.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .registry_name = "RegistryName",
        .tags = "Tags",
    };
};

pub const CreateRegistryOutput = struct {
    /// A description of the registry.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the newly created registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The tags for the registry.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistryInput, options: CallOptions) !CreateRegistryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateRegistry");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRegistryOutput, body, allocator);
}
