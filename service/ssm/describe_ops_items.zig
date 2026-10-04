const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpsItemFilter = @import("ops_item_filter.zig").OpsItemFilter;
const OpsItemSummary = @import("ops_item_summary.zig").OpsItemSummary;

pub const DescribeOpsItemsInput = struct {
    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// A token to start the list. Use this token to get the next set of results.
    next_token: ?[]const u8 = null,

    /// One or more filters to limit the response.
    ///
    /// * Key: CreatedTime
    ///
    /// Operations: GreaterThan, LessThan
    ///
    /// * Key: LastModifiedBy
    ///
    /// Operations: Contains, Equals
    ///
    /// * Key: LastModifiedTime
    ///
    /// Operations: GreaterThan, LessThan
    ///
    /// * Key: Priority
    ///
    /// Operations: Equals
    ///
    /// * Key: Source
    ///
    /// Operations: Contains, Equals
    ///
    /// * Key: Status
    ///
    /// Operations: Equals
    ///
    /// * Key: Title*
    ///
    /// Operations: Equals,Contains
    ///
    /// * Key: OperationalData**
    ///
    /// Operations: Equals
    ///
    /// * Key: OperationalDataKey
    ///
    /// Operations: Equals
    ///
    /// * Key: OperationalDataValue
    ///
    /// Operations: Equals, Contains
    ///
    /// * Key: OpsItemId
    ///
    /// Operations: Equals
    ///
    /// * Key: ResourceId
    ///
    /// Operations: Contains
    ///
    /// * Key: AutomationId
    ///
    /// Operations: Equals
    ///
    /// * Key: AccountId
    ///
    /// Operations: Equals
    ///
    /// *The Equals operator for Title matches the first 100 characters. If you
    /// specify more than
    /// 100 characters, they system returns an error that the filter value exceeds
    /// the length
    /// limit.
    ///
    /// **If you filter the response by using the OperationalData operator, specify
    /// a key-value pair
    /// by using the following JSON format: {"key":"key_name","value":"a_value"}
    ops_item_filters: ?[]const OpsItemFilter = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .ops_item_filters = "OpsItemFilters",
    };
};

pub const DescribeOpsItemsOutput = struct {
    /// The token for the next set of items to return. Use this token to get the
    /// next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of OpsItems.
    ops_item_summaries: ?[]const OpsItemSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .ops_item_summaries = "OpsItemSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOpsItemsInput, options: CallOptions) !DescribeOpsItemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOpsItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeOpsItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOpsItemsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeOpsItemsOutput, body, allocator);
}
