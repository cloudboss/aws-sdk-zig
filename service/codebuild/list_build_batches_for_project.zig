const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuildBatchFilter = @import("build_batch_filter.zig").BuildBatchFilter;
const SortOrderType = @import("sort_order_type.zig").SortOrderType;

pub const ListBuildBatchesForProjectInput = struct {
    /// A `BuildBatchFilter` object that specifies the filters for the search.
    filter: ?BuildBatchFilter = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous call to
    /// `ListBuildBatchesForProject`. This specifies the next item to return. To
    /// return the
    /// beginning of the list, exclude this parameter.
    next_token: ?[]const u8 = null,

    /// The name of the project.
    project_name: ?[]const u8 = null,

    /// Specifies the sort order of the returned items. Valid values include:
    ///
    /// * `ASCENDING`: List the batch build identifiers in ascending order by
    /// identifier.
    ///
    /// * `DESCENDING`: List the batch build identifiers in descending order
    /// by identifier.
    sort_order: ?SortOrderType = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .project_name = "projectName",
        .sort_order = "sortOrder",
    };
};

pub const ListBuildBatchesForProjectOutput = struct {
    /// An array of strings that contains the batch build identifiers.
    ids: ?[]const []const u8 = null,

    /// If there are more items to return, this contains a token that is passed to a
    /// subsequent call to `ListBuildBatchesForProject` to retrieve the next set of
    /// items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBuildBatchesForProjectInput, options: CallOptions) !ListBuildBatchesForProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBuildBatchesForProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.ListBuildBatchesForProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBuildBatchesForProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListBuildBatchesForProjectOutput, body, allocator);
}
