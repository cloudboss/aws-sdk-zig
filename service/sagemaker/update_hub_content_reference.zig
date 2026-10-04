const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubContentType = @import("hub_content_type.zig").HubContentType;

pub const UpdateHubContentReferenceInput = struct {
    /// The name of the hub content resource that you want to update.
    hub_content_name: []const u8,

    /// The content type of the resource that you want to update. Only specify a
    /// `ModelReference` resource for this API. To update a `Model` or `Notebook`
    /// resource, use the `UpdateHubContent` API instead.
    hub_content_type: HubContentType,

    /// The name of the SageMaker hub that contains the hub content you want to
    /// update. You can optionally use the hub ARN instead.
    hub_name: []const u8,

    /// The minimum hub content version of the referenced model that you want to
    /// use. The minimum version must be older than the latest available version of
    /// the referenced model. To support all versions of a model, set the value to
    /// `1.0.0`.
    min_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .hub_content_type = "HubContentType",
        .hub_name = "HubName",
        .min_version = "MinVersion",
    };
};

pub const UpdateHubContentReferenceOutput = struct {
    /// The ARN of the private model hub that contains the updated hub content.
    hub_arn: []const u8,

    /// The ARN of the hub content resource that was updated.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHubContentReferenceInput, options: CallOptions) !UpdateHubContentReferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHubContentReferenceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateHubContentReference");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHubContentReferenceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateHubContentReferenceOutput, body, allocator);
}
