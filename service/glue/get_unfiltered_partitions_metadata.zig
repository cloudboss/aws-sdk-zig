const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const QuerySessionContext = @import("query_session_context.zig").QuerySessionContext;
const Segment = @import("segment.zig").Segment;
const PermissionType = @import("permission_type.zig").PermissionType;
const UnfilteredPartition = @import("unfiltered_partition.zig").UnfilteredPartition;

pub const GetUnfilteredPartitionsMetadataInput = struct {
    /// A structure containing Lake Formation audit context information.
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the partitions in question reside. If none
    /// is provided,
    /// the AWS account ID is used by default.
    catalog_id: []const u8,

    /// The name of the catalog database where the partitions reside.
    database_name: []const u8,

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
    expression: ?[]const u8 = null,

    /// The maximum number of partitions to return in a single response.
    max_results: ?i32 = null,

    /// A continuation token, if this is not the first call to retrieve
    /// these partitions.
    next_token: ?[]const u8 = null,

    /// A structure used as a protocol between query engines and Lake Formation or
    /// Glue. Contains both a Lake Formation generated authorization identifier and
    /// information from the request's authorization context.
    query_session_context: ?QuerySessionContext = null,

    /// Specified only if the base tables belong to a different Amazon Web Services
    /// Region.
    region: ?[]const u8 = null,

    /// The segment of the table's partitions to scan in this request.
    segment: ?Segment = null,

    /// A list of supported permission types.
    supported_permission_types: []const PermissionType,

    /// The name of the table that contains the partition.
    table_name: []const u8,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .expression = "Expression",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .query_session_context = "QuerySessionContext",
        .region = "Region",
        .segment = "Segment",
        .supported_permission_types = "SupportedPermissionTypes",
        .table_name = "TableName",
    };
};

pub const GetUnfilteredPartitionsMetadataOutput = struct {
    /// A continuation token, if the returned list of partitions does not include
    /// the last
    /// one.
    next_token: ?[]const u8 = null,

    /// A list of requested partitions.
    unfiltered_partitions: ?[]const UnfilteredPartition = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .unfiltered_partitions = "UnfilteredPartitions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUnfilteredPartitionsMetadataInput, options: CallOptions) !GetUnfilteredPartitionsMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUnfilteredPartitionsMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetUnfilteredPartitionsMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUnfilteredPartitionsMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUnfilteredPartitionsMetadataOutput, body, allocator);
}
