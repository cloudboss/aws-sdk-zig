const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PullThroughCacheRule = @import("pull_through_cache_rule.zig").PullThroughCacheRule;

pub const DescribePullThroughCacheRulesInput = struct {
    /// The Amazon ECR repository prefixes associated with the pull through cache
    /// rules to return.
    /// If no repository prefix value is specified, all pull through cache rules are
    /// returned.
    ecr_repository_prefixes: ?[]const []const u8 = null,

    /// The maximum number of pull through cache rules returned by
    /// `DescribePullThroughCacheRulesRequest` in paginated output. When this
    /// parameter is used, `DescribePullThroughCacheRulesRequest` only returns
    /// `maxResults` results in a single page along with a `nextToken`
    /// response element. The remaining results of the initial request can be seen
    /// by sending
    /// another `DescribePullThroughCacheRulesRequest` request with the returned
    /// `nextToken` value. This value can be between 1 and 1000. If this
    /// parameter is not used, then `DescribePullThroughCacheRulesRequest` returns
    /// up
    /// to 100 results and a `nextToken` value, if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribePullThroughCacheRulesRequest` request where
    /// `maxResults` was used and the results exceeded the value of that
    /// parameter. Pagination continues from the end of the previous results that
    /// returned the
    /// `nextToken` value. This value is null when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry to return
    /// the pull through cache
    /// rules for. If you do not specify a registry, the default registry is
    /// assumed.
    registry_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ecr_repository_prefixes = "ecrRepositoryPrefixes",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
    };
};

pub const DescribePullThroughCacheRulesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `DescribePullThroughCacheRulesRequest` request. When the results of a
    /// `DescribePullThroughCacheRulesRequest` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of
    /// results. This value is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The details of the pull through cache rules.
    pull_through_cache_rules: ?[]const PullThroughCacheRule = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .pull_through_cache_rules = "pullThroughCacheRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePullThroughCacheRulesInput, options: CallOptions) !DescribePullThroughCacheRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePullThroughCacheRulesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DescribePullThroughCacheRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePullThroughCacheRulesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePullThroughCacheRulesOutput, body, allocator);
}
