const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const Segment = @import("segment.zig").Segment;
const Partition = @import("partition.zig").Partition;

pub const GetPartitionsInput = struct {
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the partitions in question reside. If none
    /// is provided,
    /// the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database where the partitions reside.
    database_name: []const u8,

    /// When true, specifies not returning the partition column schema. Useful when
    /// you are interested only in other partition attributes such as partition
    /// values or location. This approach avoids the problem of a large response by
    /// not returning duplicate data.
    exclude_column_schema: ?bool = null,

    /// An expression that filters the partitions to be returned.
    ///
    /// The expression uses SQL syntax similar to the SQL `WHERE` filter clause. The
    /// SQL statement parser
    /// [JSQLParser](http://jsqlparser.sourceforge.net/home.php) parses the
    /// expression.
    ///
    /// *Operators*: The following are the operators that you can use in the
    /// `Expression` API call:
    ///
    /// **=**
    ///
    /// Checks whether the values of the two operands are equal; if yes, then the
    /// condition becomes
    /// true.
    ///
    /// Example: Assume 'variable a' holds 10 and 'variable b' holds 20.
    ///
    /// (a = b) is not true.
    ///
    /// ****
    ///
    /// Checks whether the values of two operands are equal; if the values are not
    /// equal,
    /// then the condition becomes true.
    ///
    /// Example: (a b) is true.
    ///
    /// **>**
    ///
    /// Checks whether the value of the left operand is greater than the value of
    /// the right
    /// operand; if yes, then the condition becomes true.
    ///
    /// Example: (a > b) is not true.
    ///
    /// **=**
    ///
    /// Checks whether the value of the left operand is greater than or equal to the
    /// value
    /// of the right operand; if yes, then the condition becomes true.
    ///
    /// Example: (a >= b) is not true.
    ///
    /// **<=**
    ///
    /// Checks whether the value of the left operand is less than or equal to the
    /// value of
    /// the right operand; if yes, then the condition becomes true.
    ///
    /// Example: (a <= b) is true.
    ///
    /// **AND, OR, IN, BETWEEN, LIKE, NOT, IS NULL**
    ///
    /// Logical operators.
    ///
    /// *Supported Partition Key Types*: The following are the supported
    /// partition keys.
    ///
    /// * `string`
    ///
    /// * `date`
    ///
    /// * `timestamp`
    ///
    /// * `int`
    ///
    /// * `bigint`
    ///
    /// * `long`
    ///
    /// * `tinyint`
    ///
    /// * `smallint`
    ///
    /// * `decimal`
    ///
    /// If an type is encountered that is not valid, an exception is thrown.
    ///
    /// The following list shows the valid operators on each type. When you define a
    /// crawler, the
    /// `partitionKey` type is created as a `STRING`, to be compatible with the
    /// catalog
    /// partitions.
    ///
    /// *Sample API Call*:
    expression: ?[]const u8 = null,

    /// The maximum number of partitions to return in a single response.
    max_results: ?i32 = null,

    /// A continuation token, if this is not the first call to retrieve
    /// these partitions.
    next_token: ?[]const u8 = null,

    /// The time as of when to read the partition contents. If not set, the most
    /// recent transaction commit time will be used. Cannot be specified along with
    /// `TransactionId`.
    query_as_of_time: ?i64 = null,

    /// The segment of the table's partitions to scan in this request.
    segment: ?Segment = null,

    /// The name of the partitions' table.
    table_name: []const u8,

    /// The transaction ID at which to read the partition contents.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .exclude_column_schema = "ExcludeColumnSchema",
        .expression = "Expression",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .query_as_of_time = "QueryAsOfTime",
        .segment = "Segment",
        .table_name = "TableName",
        .transaction_id = "TransactionId",
    };
};

pub const GetPartitionsOutput = struct {
    /// A continuation token, if the returned list of partitions does not include
    /// the last
    /// one.
    next_token: ?[]const u8 = null,

    /// A list of requested partitions.
    partitions: ?[]const Partition = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .partitions = "Partitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartitionsInput, options: CallOptions) !GetPartitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetPartitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPartitionsOutput, body, allocator);
}
