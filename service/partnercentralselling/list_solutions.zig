const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SolutionSort = @import("solution_sort.zig").SolutionSort;
const SolutionStatus = @import("solution_status.zig").SolutionStatus;
const SolutionBase = @import("solution_base.zig").SolutionBase;

pub const ListSolutionsInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the solutions are listed in. Use `AWS` to list solutions
    /// in the Amazon Web Services catalog, and `Sandbox` to list solutions in a
    /// secure and isolated testing environment.
    catalog: []const u8,

    /// Filters the solutions based on the category to which they belong. This
    /// allows partners to search for solutions within specific categories, such as
    /// `Software`, `Consulting`, or `Managed Services`.
    category: ?[]const []const u8 = null,

    /// Filters the solutions based on their unique identifier. Use this filter to
    /// retrieve specific solutions by providing the solution's identifier for
    /// accurate results.
    identifier: ?[]const []const u8 = null,

    /// The maximum number of results returned by a single call. This value must be
    /// provided in the next call to retrieve the next set of results.
    ///
    /// Default: 20
    max_results: ?i32 = null,

    /// A pagination token used to retrieve the next set of results in subsequent
    /// calls. This token is included in the response only if there are additional
    /// result pages available.
    next_token: ?[]const u8 = null,

    /// Object that configures sorting done on the response. Default `Sort.SortBy`
    /// is `Identifier`.
    sort: ?SolutionSort = null,

    /// Filters solutions based on their status. This filter helps partners manage
    /// their solution portfolios effectively.
    status: ?[]const SolutionStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .category = "Category",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
        .status = "Status",
    };
};

pub const ListSolutionsOutput = struct {
    /// A pagination token used to retrieve the next set of results in subsequent
    /// calls. This token is included in the response only if there are additional
    /// result pages available.
    next_token: ?[]const u8 = null,

    /// An array with minimal details for solutions matching the request criteria.
    solution_summaries: ?[]const SolutionBase = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .solution_summaries = "SolutionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSolutionsInput, options: CallOptions) !ListSolutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSolutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListSolutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSolutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListSolutionsOutput, body, allocator);
}
