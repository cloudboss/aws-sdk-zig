const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryCreationTemplate = @import("repository_creation_template.zig").RepositoryCreationTemplate;

pub const DescribeRepositoryCreationTemplatesInput = struct {
    /// The maximum number of repository results returned by
    /// `DescribeRepositoryCreationTemplatesRequest` in paginated output. When
    /// this parameter is used, `DescribeRepositoryCreationTemplatesRequest` only
    /// returns `maxResults` results in a single page along with a
    /// `nextToken` response element. The remaining results of the initial
    /// request can be seen by sending another
    /// `DescribeRepositoryCreationTemplatesRequest` request with the returned
    /// `nextToken` value. This value can be between 1 and
    /// 1000. If this parameter is not used, then
    /// `DescribeRepositoryCreationTemplatesRequest` returns up to
    /// 100 results and a `nextToken` value, if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribeRepositoryCreationTemplates` request where
    /// `maxResults` was used and the results exceeded the value of that
    /// parameter. Pagination continues from the end of the previous results that
    /// returned the
    /// `nextToken` value. This value is `null` when there are no more
    /// results to return.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The repository namespace prefixes associated with the repository creation
    /// templates to
    /// describe. If this value is not specified, all repository creation templates
    /// are
    /// returned.
    prefixes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .prefixes = "prefixes",
    };
};

pub const DescribeRepositoryCreationTemplatesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `DescribeRepositoryCreationTemplates` request. When the results of a
    /// `DescribeRepositoryCreationTemplates` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of
    /// results. This value is `null` when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The details of the repository creation templates.
    repository_creation_templates: ?[]const RepositoryCreationTemplate = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .registry_id = "registryId",
        .repository_creation_templates = "repositoryCreationTemplates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRepositoryCreationTemplatesInput, options: CallOptions) !DescribeRepositoryCreationTemplatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRepositoryCreationTemplatesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DescribeRepositoryCreationTemplates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRepositoryCreationTemplatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRepositoryCreationTemplatesOutput, body, allocator);
}
