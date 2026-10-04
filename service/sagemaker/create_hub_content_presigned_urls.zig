const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PresignedUrlAccessConfig = @import("presigned_url_access_config.zig").PresignedUrlAccessConfig;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const AuthorizedUrl = @import("authorized_url.zig").AuthorizedUrl;

pub const CreateHubContentPresignedUrlsInput = struct {
    /// Configuration settings for accessing the hub content, including end-user
    /// license agreement acceptance for gated models and expected S3 URL
    /// validation.
    access_config: ?PresignedUrlAccessConfig = null,

    /// The name of the hub content for which to generate presigned URLs. This
    /// identifies the specific model or content within the hub.
    hub_content_name: []const u8,

    /// The type of hub content to access. Valid values include `Model`, `Notebook`,
    /// and `ModelReference`.
    hub_content_type: HubContentType,

    /// The version of the hub content. If not specified, the latest version is
    /// used.
    hub_content_version: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the hub that contains the content.
    /// For public content, use `SageMakerPublicHub`.
    hub_name: []const u8,

    /// The maximum number of presigned URLs to return in the response. Default
    /// value is 100. Large models may contain hundreds of files, requiring
    /// pagination to retrieve all URLs.
    max_results: ?i32 = null,

    /// A token for pagination. Use this token to retrieve the next set of presigned
    /// URLs when the response is truncated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_config = "AccessConfig",
        .hub_content_name = "HubContentName",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const CreateHubContentPresignedUrlsOutput = struct {
    /// An array of authorized URL configurations, each containing a presigned URL
    /// and its corresponding local file path for proper file organization during
    /// download.
    authorized_url_configs: ?[]const AuthorizedUrl = null,

    /// A token for pagination. If present, indicates that more presigned URLs are
    /// available. Use this token in a subsequent request to retrieve additional
    /// URLs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorized_url_configs = "AuthorizedUrlConfigs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHubContentPresignedUrlsInput, options: CallOptions) !CreateHubContentPresignedUrlsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHubContentPresignedUrlsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHubContentPresignedUrls");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHubContentPresignedUrlsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHubContentPresignedUrlsOutput, body, allocator);
}
