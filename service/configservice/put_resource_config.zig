const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourceConfigInput = struct {
    /// The configuration object of the resource in valid JSON format. It must match
    /// the schema registered with CloudFormation.
    ///
    /// The configuration JSON must not exceed 64 KB.
    configuration: []const u8,

    /// Unique identifier of the resource.
    resource_id: []const u8,

    /// Name of the resource.
    resource_name: ?[]const u8 = null,

    /// The type of the resource. The custom resource type must be registered with
    /// CloudFormation.
    ///
    /// You cannot use the organization names “amzn”, “amazon”, “alexa”, “custom”
    /// with custom resource types. It is the first part of the ResourceType up to
    /// the first ::.
    resource_type: []const u8,

    /// Version of the schema registered for the ResourceType in CloudFormation.
    schema_version_id: []const u8,

    /// Tags associated with the resource.
    ///
    /// This field is not to be confused with the Amazon Web Services-wide tag
    /// feature for Amazon Web Services resources.
    /// Tags for `PutResourceConfig` are tags that you supply for the configuration
    /// items of your custom resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .resource_id = "ResourceId",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .schema_version_id = "SchemaVersionId",
        .tags = "Tags",
    };
};

pub const PutResourceConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourceConfigInput, options: CallOptions) !PutResourceConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourceConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutResourceConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourceConfigOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
