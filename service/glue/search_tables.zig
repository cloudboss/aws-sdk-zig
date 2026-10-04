const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertyPredicate = @import("property_predicate.zig").PropertyPredicate;
const ResourceShareType = @import("resource_share_type.zig").ResourceShareType;
const SortCriterion = @import("sort_criterion.zig").SortCriterion;
const Table = @import("table.zig").Table;

pub const SearchTablesInput = struct {
    /// A unique identifier, consisting of `
    /// *account_id*
    /// `.
    catalog_id: ?[]const u8 = null,

    /// A list of key-value pairs, and a comparator used to filter the search
    /// results. Returns all entities matching the predicate.
    ///
    /// The `Comparator` member of the `PropertyPredicate` struct is used only for
    /// time fields, and can be omitted for other field types. Also, when comparing
    /// string values, such as when `Key=Name`, a fuzzy match algorithm is used. The
    /// `Key` field (for example, the value of the `Name` field) is split on certain
    /// punctuation characters, for example, -, :, #, etc. into tokens. Then each
    /// token is exact-match compared with the `Value` member of
    /// `PropertyPredicate`. For example, if `Key=Name` and `Value=link`, tables
    /// named `customer-link` and `xx-link-yy` are returned, but `xxlinkyy` is not
    /// returned.
    filters: ?[]const PropertyPredicate = null,

    /// Specifies whether to include status details related to a request to create
    /// or update an Glue Data Catalog view.
    include_status_details: ?bool = null,

    /// The maximum number of tables to return in a single response.
    max_results: ?i32 = null,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// Allows you to specify that you want to search the tables shared with your
    /// account. The allowable values are `FOREIGN` or `ALL`.
    ///
    /// * If set to `FOREIGN`, will search the tables shared with your account.
    ///
    /// * If set to `ALL`, will search the tables shared with your account, as well
    ///   as the tables in yor local account.
    resource_share_type: ?ResourceShareType = null,

    /// A string used for a text search.
    ///
    /// Specifying a value in quotes filters based on an exact match to the value.
    search_text: ?[]const u8 = null,

    /// A list of criteria for sorting the results by a field name, in an ascending
    /// or descending order.
    sort_criteria: ?[]const SortCriterion = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .filters = "Filters",
        .include_status_details = "IncludeStatusDetails",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_share_type = "ResourceShareType",
        .search_text = "SearchText",
        .sort_criteria = "SortCriteria",
    };
};

pub const SearchTablesOutput = struct {
    /// A continuation token, present if the current list segment is not the last.
    next_token: ?[]const u8 = null,

    /// A list of the requested `Table` objects. The `SearchTables` response returns
    /// only the tables that you have access to.
    table_list: ?[]const Table = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .table_list = "TableList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchTablesInput, options: CallOptions) !SearchTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.SearchTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchTablesOutput, body, allocator);
}
