const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VirtualObject = @import("virtual_object.zig").VirtualObject;

pub const DeleteObjectsOnCancelInput = struct {
    /// The Glue data catalog that contains the governed table. Defaults to the
    /// current account ID.
    catalog_id: ?[]const u8 = null,

    /// The database that contains the governed table.
    database_name: []const u8,

    /// A list of VirtualObject structures, which indicates the Amazon S3 objects to
    /// be deleted if the transaction cancels.
    objects: []const VirtualObject,

    /// The name of the governed table.
    table_name: []const u8,

    /// ID of the transaction that the writes occur in.
    transaction_id: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .objects = "Objects",
        .table_name = "TableName",
        .transaction_id = "TransactionId",
    };
};

pub const DeleteObjectsOnCancelOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteObjectsOnCancelInput, options: CallOptions) !DeleteObjectsOnCancelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteObjectsOnCancelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DeleteObjectsOnCancel";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Objects\":");
    try aws.json.writeValue(@TypeOf(input.objects), input.objects, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TableName\":");
    try aws.json.writeValue(@TypeOf(input.table_name), input.table_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TransactionId\":");
    try aws.json.writeValue(@TypeOf(input.transaction_id), input.transaction_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteObjectsOnCancelOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteObjectsOnCancelOutput = .{};

    return result;
}
