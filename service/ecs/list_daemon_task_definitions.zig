const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonTaskDefinitionRevisionFilter = @import("daemon_task_definition_revision_filter.zig").DaemonTaskDefinitionRevisionFilter;
const SortOrder = @import("sort_order.zig").SortOrder;
const DaemonTaskDefinitionStatusFilter = @import("daemon_task_definition_status_filter.zig").DaemonTaskDefinitionStatusFilter;
const DaemonTaskDefinitionSummary = @import("daemon_task_definition_summary.zig").DaemonTaskDefinitionSummary;

pub const ListDaemonTaskDefinitionsInput = struct {
    /// The exact name of the daemon task definition family to filter results with.
    family: ?[]const u8 = null,

    /// The full family name to filter the `ListDaemonTaskDefinitions` results with.
    /// Specifying a `familyPrefix` limits the listed daemon task definitions to
    /// daemon task definition families that start with the `familyPrefix` string.
    family_prefix: ?[]const u8 = null,

    /// The maximum number of daemon task definition results that
    /// `ListDaemonTaskDefinitions` returned in paginated output. When this
    /// parameter is used, `ListDaemonTaskDefinitions` only returns `maxResults`
    /// results in a single page along with a `nextToken` response element. The
    /// remaining results of the initial request can be seen by sending another
    /// `ListDaemonTaskDefinitions` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't used, then
    /// `ListDaemonTaskDefinitions` returns up to 100 results and a `nextToken`
    /// value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListDaemonTaskDefinitions` request
    /// indicating that more results are available to fulfill the request and
    /// further calls will be needed. If `maxResults` was provided, it's possible
    /// for the number of results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The revision filter to apply. Specify `LAST_REGISTERED` to return only the
    /// last registered revision for each daemon task definition family.
    revision: ?DaemonTaskDefinitionRevisionFilter = null,

    /// The order to sort the results. Valid values are `ASC` and `DESC`. By default
    /// (`ASC`), daemon task definitions are listed in ascending order by family
    /// name and revision number.
    sort: ?SortOrder = null,

    /// The daemon task definition status to filter the `ListDaemonTaskDefinitions`
    /// results with. By default, only `ACTIVE` daemon task definitions are listed.
    /// If you set this parameter to `DELETE_IN_PROGRESS`, only daemon task
    /// definitions that are in the process of being deleted are listed. If you set
    /// this parameter to `ALL`, all daemon task definitions are listed regardless
    /// of status.
    status: ?DaemonTaskDefinitionStatusFilter = null,

    pub const json_field_names = .{
        .family = "family",
        .family_prefix = "familyPrefix",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .revision = "revision",
        .sort = "sort",
        .status = "status",
    };
};

pub const ListDaemonTaskDefinitionsOutput = struct {
    /// The list of daemon task definition summaries.
    daemon_task_definitions: ?[]const DaemonTaskDefinitionSummary = null,

    /// The `nextToken` value to include in a future `ListDaemonTaskDefinitions`
    /// request. When the results of a `ListDaemonTaskDefinitions` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .daemon_task_definitions = "daemonTaskDefinitions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDaemonTaskDefinitionsInput, options: CallOptions) !ListDaemonTaskDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDaemonTaskDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListDaemonTaskDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDaemonTaskDefinitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDaemonTaskDefinitionsOutput, body, allocator);
}
