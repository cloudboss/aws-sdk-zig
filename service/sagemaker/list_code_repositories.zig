const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeRepositorySortBy = @import("code_repository_sort_by.zig").CodeRepositorySortBy;
const CodeRepositorySortOrder = @import("code_repository_sort_order.zig").CodeRepositorySortOrder;
const CodeRepositorySummary = @import("code_repository_summary.zig").CodeRepositorySummary;

pub const ListCodeRepositoriesInput = struct {
    /// A filter that returns only Git repositories that were created after the
    /// specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only Git repositories that were created before the
    /// specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns only Git repositories that were last modified after
    /// the specified time.
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only Git repositories that were last modified before
    /// the specified time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of Git repositories to return in the response.
    max_results: ?i32 = null,

    /// A string in the Git repositories name. This filter returns only repositories
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of a `ListCodeRepositoriesOutput` request was truncated, the
    /// response includes a `NextToken`. To get the next set of Git repositories,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `Name`.
    sort_by: ?CodeRepositorySortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?CodeRepositorySortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListCodeRepositoriesOutput = struct {
    /// Gets a list of summaries of the Git repositories. Each summary specifies the
    /// following values for the repository:
    ///
    /// * Name
    /// * Amazon Resource Name (ARN)
    /// * Creation time
    /// * Last modified time
    /// * Configuration information, including the URL location of the repository
    ///   and the ARN of the Amazon Web Services Secrets Manager secret that
    ///   contains the credentials used to access the repository.
    code_repository_summary_list: ?[]const CodeRepositorySummary = null,

    /// If the result of a `ListCodeRepositoriesOutput` request was truncated, the
    /// response includes a `NextToken`. To get the next set of Git repositories,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_repository_summary_list = "CodeRepositorySummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCodeRepositoriesInput, options: CallOptions) !ListCodeRepositoriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCodeRepositoriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListCodeRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCodeRepositoriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListCodeRepositoriesOutput, body, allocator);
}
