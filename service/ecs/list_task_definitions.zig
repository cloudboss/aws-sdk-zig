const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const TaskDefinitionStatus = @import("task_definition_status.zig").TaskDefinitionStatus;

pub const ListTaskDefinitionsInput = struct {
    /// The full family name to filter the `ListTaskDefinitions` results with.
    /// Specifying a `familyPrefix` limits the listed task definitions to task
    /// definition revisions that belong to that family.
    family_prefix: ?[]const u8 = null,

    /// The maximum number of task definition results that `ListTaskDefinitions`
    /// returned in paginated output. When this parameter is used,
    /// `ListTaskDefinitions` only returns `maxResults` results in a single page
    /// along with a `nextToken` response element. The remaining results of the
    /// initial request can be seen by sending another `ListTaskDefinitions` request
    /// with the returned `nextToken` value. This value can be between 1 and 100. If
    /// this parameter isn't used, then `ListTaskDefinitions` returns up to 100
    /// results and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListTaskDefinitions` request
    /// indicating that more results are available to fulfill the request and
    /// further calls will be needed. If `maxResults` was provided, it is possible
    /// the number of results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The order to sort the results in. Valid values are `ASC` and `DESC`. By
    /// default, (`ASC`) task definitions are listed lexicographically by family
    /// name and in ascending numerical order by revision so that the newest task
    /// definitions in a family are listed last. Setting this parameter to `DESC`
    /// reverses the sort order on family name and revision. This is so that the
    /// newest task definitions in a family are listed first.
    sort: ?SortOrder = null,

    /// The task definition status to filter the `ListTaskDefinitions` results with.
    /// By default, only `ACTIVE` task definitions are listed. By setting this
    /// parameter to `INACTIVE`, you can view task definitions that are `INACTIVE`
    /// as long as an active task or service still references them. If you paginate
    /// the resulting output, be sure to keep the `status` value constant in each
    /// subsequent request.
    status: ?TaskDefinitionStatus = null,

    pub const json_field_names = .{
        .family_prefix = "familyPrefix",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort = "sort",
        .status = "status",
    };
};

pub const ListTaskDefinitionsOutput = struct {
    /// The `nextToken` value to include in a future `ListTaskDefinitions` request.
    /// When the results of a `ListTaskDefinitions` request exceed `maxResults`,
    /// this value can be used to retrieve the next page of results. This value is
    /// `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The list of task definition Amazon Resource Name (ARN) entries for the
    /// `ListTaskDefinitions` request.
    task_definition_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .task_definition_arns = "taskDefinitionArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTaskDefinitionsInput, options: CallOptions) !ListTaskDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTaskDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListTaskDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTaskDefinitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTaskDefinitionsOutput, body, allocator);
}
