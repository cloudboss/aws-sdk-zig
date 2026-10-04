const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateHubContentReferenceInput = struct {
    /// The name of the hub content to reference.
    hub_content_name: ?[]const u8 = null,

    /// The name of the hub to add the hub content reference to.
    hub_name: []const u8,

    /// The minimum version of the hub content to reference.
    min_version: ?[]const u8 = null,

    /// The ARN of the public hub content to reference.
    sage_maker_public_hub_content_arn: []const u8,

    /// Any tags associated with the hub content to reference.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .hub_name = "HubName",
        .min_version = "MinVersion",
        .sage_maker_public_hub_content_arn = "SageMakerPublicHubContentArn",
        .tags = "Tags",
    };
};

pub const CreateHubContentReferenceOutput = struct {
    /// The ARN of the hub that the hub content reference was added to.
    hub_arn: []const u8,

    /// The ARN of the hub content.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHubContentReferenceInput, options: CallOptions) !CreateHubContentReferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHubContentReferenceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHubContentReference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHubContentReferenceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHubContentReferenceOutput, body, allocator);
}
