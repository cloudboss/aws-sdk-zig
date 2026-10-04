const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubS3StorageConfig = @import("hub_s3_storage_config.zig").HubS3StorageConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateHubInput = struct {
    /// A description of the hub.
    hub_description: []const u8,

    /// The display name of the hub.
    hub_display_name: ?[]const u8 = null,

    /// The name of the hub to create.
    hub_name: []const u8,

    /// The searchable keywords for the hub.
    hub_search_keywords: ?[]const []const u8 = null,

    /// The Amazon S3 storage configuration for the hub.
    s3_storage_config: ?HubS3StorageConfig = null,

    /// Any tags to associate with the hub.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .hub_description = "HubDescription",
        .hub_display_name = "HubDisplayName",
        .hub_name = "HubName",
        .hub_search_keywords = "HubSearchKeywords",
        .s3_storage_config = "S3StorageConfig",
        .tags = "Tags",
    };
};

pub const CreateHubOutput = struct {
    /// The Amazon Resource Name (ARN) of the hub.
    hub_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHubInput, options: CallOptions) !CreateHubOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHubInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHub");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHubOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHubOutput, body, allocator);
}
