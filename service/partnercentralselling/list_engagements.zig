const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;
const EngagementSort = @import("engagement_sort.zig").EngagementSort;
const EngagementSummary = @import("engagement_summary.zig").EngagementSummary;

pub const ListEngagementsInput = struct {
    /// Specifies the catalog related to the request.
    catalog: []const u8,

    /// Filters engagements to include only those containing the specified context
    /// types, such as "CustomerProject" or "Lead". Use this to find engagements
    /// that have specific types of contextual information associated with them.
    context_types: ?[]const EngagementContextType = null,

    /// A list of AWS account IDs. When specified, the response includes engagements
    /// created by these accounts. This filter is useful for finding engagements
    /// created by specific team members.
    created_by: ?[]const []const u8 = null,

    /// An array of strings representing engagement identifiers to retrieve.
    engagement_identifier: ?[]const []const u8 = null,

    /// Filters engagements to exclude those containing the specified context types.
    /// Use this to find engagements that do not have certain types of contextual
    /// information, helping to narrow results based on context exclusion criteria.
    exclude_context_types: ?[]const EngagementContextType = null,

    /// An array of strings representing AWS Account IDs. Use this to exclude
    /// engagements created by specific users.
    exclude_created_by: ?[]const []const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next set of results. This value is returned from a
    /// previous call.
    next_token: ?[]const u8 = null,

    sort: ?EngagementSort = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .context_types = "ContextTypes",
        .created_by = "CreatedBy",
        .engagement_identifier = "EngagementIdentifier",
        .exclude_context_types = "ExcludeContextTypes",
        .exclude_created_by = "ExcludeCreatedBy",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
    };
};

pub const ListEngagementsOutput = struct {
    /// An array of engagement summary objects.
    engagement_summary_list: ?[]const EngagementSummary = null,

    /// The token to retrieve the next set of results. This field will be null if
    /// there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagement_summary_list = "EngagementSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementsInput, options: CallOptions) !ListEngagementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEngagementsOutput, body, allocator);
}
