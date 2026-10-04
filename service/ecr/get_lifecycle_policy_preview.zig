const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecyclePolicyPreviewFilter = @import("lifecycle_policy_preview_filter.zig").LifecyclePolicyPreviewFilter;
const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;
const LifecyclePolicyPreviewResult = @import("lifecycle_policy_preview_result.zig").LifecyclePolicyPreviewResult;
const LifecyclePolicyPreviewStatus = @import("lifecycle_policy_preview_status.zig").LifecyclePolicyPreviewStatus;
const LifecyclePolicyPreviewSummary = @import("lifecycle_policy_preview_summary.zig").LifecyclePolicyPreviewSummary;

pub const GetLifecyclePolicyPreviewInput = struct {
    /// An optional parameter that filters results based on image tag status and all
    /// tags, if
    /// tagged.
    filter: ?LifecyclePolicyPreviewFilter = null,

    /// The list of imageIDs to be included.
    image_ids: ?[]const ImageIdentifier = null,

    /// The maximum number of repository results returned by
    /// `GetLifecyclePolicyPreviewRequest` in  paginated output. When this
    /// parameter is used, `GetLifecyclePolicyPreviewRequest` only returns
    /// `maxResults` results in a single page along with a
    /// `nextToken`  response element. The remaining results of the initial request
    /// can be seen by sending  another `GetLifecyclePolicyPreviewRequest` request
    /// with the returned `nextToken`  value. This value can be between
    /// 1 and 100. If this  parameter is not used, then
    /// `GetLifecyclePolicyPreviewRequest` returns up to 100
    /// results and a `nextToken` value, if  applicable. This option cannot be used
    /// when you specify images with `imageIds`.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `GetLifecyclePolicyPreviewRequest` request where `maxResults`
    /// was used and the  results exceeded the value of that parameter. Pagination
    /// continues
    /// from the end of the  previous results that returned the `nextToken` value.
    /// This value is  `null` when there are no more results to return. This option
    /// cannot be used when you specify images with `imageIds`.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository.
    /// If you do not specify a registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .image_ids = "imageIds",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const GetLifecyclePolicyPreviewOutput = struct {
    /// The JSON lifecycle policy text.
    lifecycle_policy_text: ?[]const u8 = null,

    /// The `nextToken` value to include in a future
    /// `GetLifecyclePolicyPreview` request. When the results of a
    /// `GetLifecyclePolicyPreview` request exceed `maxResults`, this
    /// value can be used to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The results of the lifecycle policy preview request.
    preview_results: ?[]const LifecyclePolicyPreviewResult = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the request.
    repository_name: ?[]const u8 = null,

    /// The status of the lifecycle policy preview request.
    status: ?LifecyclePolicyPreviewStatus = null,

    /// The list of images that is returned as a result of the action.
    summary: ?LifecyclePolicyPreviewSummary = null,

    pub const json_field_names = .{
        .lifecycle_policy_text = "lifecyclePolicyText",
        .next_token = "nextToken",
        .preview_results = "previewResults",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .status = "status",
        .summary = "summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLifecyclePolicyPreviewInput, options: CallOptions) !GetLifecyclePolicyPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLifecyclePolicyPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.GetLifecyclePolicyPreview");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLifecyclePolicyPreviewOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLifecyclePolicyPreviewOutput, body, allocator);
}
