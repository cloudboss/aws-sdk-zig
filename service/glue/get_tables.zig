const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableAttributes = @import("table_attributes.zig").TableAttributes;
const AuditContext = @import("audit_context.zig").AuditContext;
const TableResourceShareType = @import("table_resource_share_type.zig").TableResourceShareType;
const Table = @import("table.zig").Table;

pub const GetTablesInput = struct {
    /// Specifies the table fields returned by the `GetTables` call. This parameter
    /// doesn’t accept an empty list. The request must include `NAME`.
    ///
    /// The following are the valid combinations of values:
    ///
    /// * `NAME` - Names of all tables in the database.
    ///
    /// * `NAME`, `TABLE_TYPE` - Names of all tables and the table types.
    attributes_to_get: ?[]const TableAttributes = null,

    /// A structure containing the Lake Formation [audit
    /// context](https://docs.aws.amazon.com/glue/latest/webapi/API_AuditContext.html).
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the tables reside. If none is provided, the
    /// Amazon Web Services account
    /// ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The database in the catalog whose tables to list. For Hive
    /// compatibility, this name is entirely lowercase.
    database_name: []const u8,

    /// A regular expression pattern. If present, only those tables
    /// whose names match the pattern are returned.
    expression: ?[]const u8 = null,

    /// Specifies whether to include status details related to a request to create
    /// or update an Glue Data Catalog view.
    include_status_details: ?bool = null,

    /// The maximum number of tables to return in a single response.
    max_results: ?i32 = null,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The time as of when to read the table contents. If not set, the most recent
    /// transaction commit time will be used. Cannot be specified along with
    /// `TransactionId`.
    query_as_of_time: ?i64 = null,

    /// Specifies which tables the `GetTables` call returns. The allowable values
    /// are `FEDERATED` or `ALL`.
    ///
    /// * If set to `FEDERATED`, returns only federated tables, which reference an
    ///   entity outside the Glue Data Catalog.
    ///
    /// * If set to `ALL`, returns all tables in the database, both federated and
    ///   non-federated.
    resource_share_type: ?TableResourceShareType = null,

    /// The transaction ID at which to read the table contents.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .expression = "Expression",
        .include_status_details = "IncludeStatusDetails",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .query_as_of_time = "QueryAsOfTime",
        .resource_share_type = "ResourceShareType",
        .transaction_id = "TransactionId",
    };
};

pub const GetTablesOutput = struct {
    /// A continuation token, present if the current list segment is not the last.
    next_token: ?[]const u8 = null,

    /// A list of the requested `Table` objects.
    table_list: ?[]const Table = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .table_list = "TableList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTablesInput, options: CallOptions) !GetTablesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTablesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetTables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTablesOutput, body, allocator);
}
