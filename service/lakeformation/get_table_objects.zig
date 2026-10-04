const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartitionObjects = @import("partition_objects.zig").PartitionObjects;

pub const GetTableObjectsInput = struct {
    /// The catalog containing the governed table. Defaults to the caller’s account.
    catalog_id: ?[]const u8 = null,

    /// The database containing the governed table.
    database_name: []const u8,

    /// Specifies how many values to return in a page.
    max_results: ?i32 = null,

    /// A continuation token if this is not the first call to retrieve these
    /// objects.
    next_token: ?[]const u8 = null,

    /// A predicate to filter the objects returned based on the partition keys
    /// defined in the governed table.
    ///
    /// * The comparison operators supported are: =, >, =, <=
    ///
    /// * The logical operators supported are: AND
    ///
    /// * The data types supported are integer, long, date(yyyy-MM-dd),
    ///   timestamp(yyyy-MM-dd HH:mm:ssXXX or yyyy-MM-dd HH:mm:ss"), string and
    ///   decimal.
    partition_predicate: ?[]const u8 = null,

    /// The time as of when to read the governed table contents. If not set, the
    /// most recent transaction commit time is used. Cannot be specified along with
    /// `TransactionId`.
    query_as_of_time: ?i64 = null,

    /// The governed table for which to retrieve objects.
    table_name: []const u8,

    /// The transaction ID at which to read the governed table contents. If this
    /// transaction has aborted, an error is returned. If not set, defaults to the
    /// most recent committed transaction. Cannot be specified along with
    /// `QueryAsOfTime`.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .partition_predicate = "PartitionPredicate",
        .query_as_of_time = "QueryAsOfTime",
        .table_name = "TableName",
        .transaction_id = "TransactionId",
    };
};

pub const GetTableObjectsOutput = struct {
    /// A continuation token indicating whether additional data is available.
    next_token: ?[]const u8 = null,

    /// A list of objects organized by partition keys.
    objects: ?[]const PartitionObjects = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .objects = "Objects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableObjectsInput, options: CallOptions) !GetTableObjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableObjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetTableObjects";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.catalog_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CatalogId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DatabaseName\":");
    try aws.json.writeValue(@TypeOf(input.database_name), input.database_name, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.partition_predicate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PartitionPredicate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_as_of_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryAsOfTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TableName\":");
    try aws.json.writeValue(@TypeOf(input.table_name), input.table_name, allocator, &body_buf);
    has_prev = true;
    if (input.transaction_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TransactionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableObjectsOutput {
    const result: GetTableObjectsOutput = try aws.json.parseJsonObject(
        GetTableObjectsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
