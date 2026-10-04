const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataCellsFilter = @import("data_cells_filter.zig").DataCellsFilter;

pub const GetDataCellsFilterInput = struct {
    /// A database in the Glue Data Catalog.
    database_name: []const u8,

    /// The name given by the user to the data filter cell.
    name: []const u8,

    /// The ID of the catalog to which the table belongs.
    table_catalog_id: []const u8,

    /// A table in the database.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .name = "Name",
        .table_catalog_id = "TableCatalogId",
        .table_name = "TableName",
    };
};

pub const GetDataCellsFilterOutput = struct {
    /// A structure that describes certain columns on certain rows.
    data_cells_filter: ?DataCellsFilter = null,

    pub const json_field_names = .{
        .data_cells_filter = "DataCellsFilter",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataCellsFilterInput, options: CallOptions) !GetDataCellsFilterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataCellsFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetDataCellsFilter";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DatabaseName\":");
    try aws.json.writeValue(@TypeOf(input.database_name), input.database_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TableCatalogId\":");
    try aws.json.writeValue(@TypeOf(input.table_catalog_id), input.table_catalog_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TableName\":");
    try aws.json.writeValue(@TypeOf(input.table_name), input.table_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataCellsFilterOutput {
    const result: GetDataCellsFilterOutput = try aws.json.parseJsonObject(
        GetDataCellsFilterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
