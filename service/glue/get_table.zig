const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableAttributes = @import("table_attributes.zig").TableAttributes;
const AuditContext = @import("audit_context.zig").AuditContext;
const Table = @import("table.zig").Table;

pub const GetTableInput = struct {
    /// Specifies the table fields returned by the `GetTable` call. This parameter
    /// doesn't accept an empty list.
    ///
    /// The following are the valid combinations of values:
    ///
    /// * `DEFAULT` - Returns the Hive-style table definition only.
    ///
    /// * `LATEST_ICEBERG_METADATA` - Returns only the latest Apache Iceberg table
    ///   metadata.
    ///
    /// * `DEFAULT`, `LATEST_ICEBERG_METADATA` - Returns both the Hive-style table
    ///   definition and the latest Apache Iceberg table metadata.
    attributes_to_get: ?[]const TableAttributes = null,

    /// A structure containing the Lake Formation [audit
    /// context](https://docs.aws.amazon.com/glue/latest/webapi/API_AuditContext.html).
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the table resides. If none is provided, the
    /// Amazon Web Services account
    /// ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the database in the catalog in which the table resides.
    /// For Hive compatibility, this name is entirely lowercase.
    database_name: []const u8,

    /// Specifies whether to include status details related to a request to create
    /// or update an Glue Data Catalog view.
    include_status_details: ?bool = null,

    /// The name of the table for which to retrieve the definition. For Hive
    /// compatibility, this name is entirely lowercase.
    name: []const u8,

    /// The time as of when to read the table contents. If not set, the most recent
    /// transaction commit time will be used. Cannot be specified along with
    /// `TransactionId`.
    query_as_of_time: ?i64 = null,

    /// The transaction ID at which to read the table contents.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes_to_get = "AttributesToGet",
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .include_status_details = "IncludeStatusDetails",
        .name = "Name",
        .query_as_of_time = "QueryAsOfTime",
        .transaction_id = "TransactionId",
    };
};

pub const GetTableOutput = struct {
    /// The `Table` object that defines the specified table.
    table: ?Table = null,

    pub const json_field_names = .{
        .table = "Table",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableInput, options: CallOptions) !GetTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTableOutput, body, allocator);
}
