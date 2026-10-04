const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexCategory = @import("index_category.zig").IndexCategory;
const FieldIndex = @import("field_index.zig").FieldIndex;

pub const DescribeFieldIndexesInput = struct {
    /// The index categories to return. The following values are supported:
    ///
    /// * `DEFAULT`: Fields that CloudWatch Logs indexes by default. Examples
    /// include `@logStream` and `@data_format`.
    ///
    /// * `CUSTOM`: Fields that you added manually to the field index policy.
    /// CloudWatch Logs always indexes these fields. These fields count toward the
    /// quota of
    /// 20 fields for each log group.
    ///
    /// * `AUTO`: Fields that CloudWatch Logs indexes automatically based on your
    /// query patterns and usage. These fields do not count toward the field index
    /// quota.
    /// CloudWatch Logs might update these fields based on changes in your query
    /// patterns. To
    /// keep a field indexed permanently, add it to an account-level or log-group
    /// level field
    /// index policy.
    ///
    /// * `INACTIVE`: Fields that CloudWatch Logs indexed before but does not
    /// index now. This happens if you remove a field from the field index policy or
    /// if
    /// CloudWatch Logs automatically selects a different field based on your
    /// queries.
    ///
    /// If you omit this parameter, the response includes the `DEFAULT`,
    /// `CUSTOM`, and `INACTIVE` categories.
    ///
    /// For more information about automatically indexed fields and using the `AUTO`
    /// category, see [Automatically indexed
    /// fields](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing-Automatic.html).
    index_categories: ?[]const IndexCategory = null,

    /// An array containing the names or ARNs of the log groups that you want to
    /// retrieve field
    /// indexes for.
    log_group_identifiers: []const []const u8,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_categories = "indexCategories",
        .log_group_identifiers = "logGroupIdentifiers",
        .next_token = "nextToken",
    };
};

pub const DescribeFieldIndexesOutput = struct {
    /// An array containing the field index information.
    field_indexes: ?[]const FieldIndex = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_indexes = "fieldIndexes",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFieldIndexesInput, options: CallOptions) !DescribeFieldIndexesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFieldIndexesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeFieldIndexes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFieldIndexesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFieldIndexesOutput, body, allocator);
}
