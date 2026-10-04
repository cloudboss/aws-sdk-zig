const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonSummary = @import("daemon_summary.zig").DaemonSummary;

pub const ListDaemonsInput = struct {
    /// The Amazon Resource Names (ARNs) of the capacity providers to filter daemons
    /// by. Only daemons associated with the specified capacity providers are
    /// returned.
    capacity_provider_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster to filter daemons by. If not
    /// specified, daemons from all clusters are returned.
    cluster_arn: ?[]const u8 = null,

    /// The maximum number of daemon results that `ListDaemons` returned in
    /// paginated output. When this parameter is used, `ListDaemons` only returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request can be seen by sending
    /// another `ListDaemons` request with the returned `nextToken` value. This
    /// value can be between 1 and 100. If this parameter isn't used, then
    /// `ListDaemons` returns up to 100 results and a `nextToken` value if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListDaemons` request indicating that
    /// more results are available to fulfill the request and further calls will be
    /// needed. If `maxResults` was provided, it's possible for the number of
    /// results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_provider_arns = "capacityProviderArns",
        .cluster_arn = "clusterArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDaemonsOutput = struct {
    /// The list of daemon summaries.
    daemon_summaries_list: ?[]const DaemonSummary = null,

    /// The `nextToken` value to include in a future `ListDaemons` request. When the
    /// results of a `ListDaemons` request exceed `maxResults`, this value can be
    /// used to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .daemon_summaries_list = "daemonSummariesList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDaemonsInput, options: CallOptions) !ListDaemonsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDaemonsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListDaemons");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDaemonsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDaemonsOutput, body, allocator);
}
