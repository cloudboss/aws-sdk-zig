const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceKey = @import("resource_key.zig").ResourceKey;
const BaseConfigurationItem = @import("base_configuration_item.zig").BaseConfigurationItem;

pub const BatchGetResourceConfigInput = struct {
    /// A list of resource keys to be processed with the current
    /// request. Each element in the list consists of the resource type and
    /// resource ID.
    resource_keys: []const ResourceKey,

    pub const json_field_names = .{
        .resource_keys = "resourceKeys",
    };
};

pub const BatchGetResourceConfigOutput = struct {
    /// A list that contains the current configuration of one or more
    /// resources.
    base_configuration_items: ?[]const BaseConfigurationItem = null,

    /// A list of resource keys that were not processed with the
    /// current response. The unprocessesResourceKeys value is in the same
    /// form as ResourceKeys, so the value can be directly provided to a
    /// subsequent BatchGetResourceConfig operation.
    ///
    /// If there are no unprocessed resource keys, the response contains an
    /// empty unprocessedResourceKeys list.
    unprocessed_resource_keys: ?[]const ResourceKey = null,

    pub const json_field_names = .{
        .base_configuration_items = "baseConfigurationItems",
        .unprocessed_resource_keys = "unprocessedResourceKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetResourceConfigInput, options: CallOptions) !BatchGetResourceConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetResourceConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.BatchGetResourceConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetResourceConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetResourceConfigOutput, body, allocator);
}
