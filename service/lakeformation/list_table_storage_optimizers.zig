const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OptimizerType = @import("optimizer_type.zig").OptimizerType;
const StorageOptimizer = @import("storage_optimizer.zig").StorageOptimizer;

pub const ListTableStorageOptimizersInput = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8 = null,

    /// Name of the database where the table is present.
    database_name: []const u8,

    /// The number of storage optimizers to return on each call.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The specific type of storage optimizers to list. The supported value is
    /// `compaction`.
    storage_optimizer_type: ?OptimizerType = null,

    /// Name of the table.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .storage_optimizer_type = "StorageOptimizerType",
        .table_name = "TableName",
    };
};

pub const ListTableStorageOptimizersOutput = struct {
    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    /// A list of the storage optimizers associated with a table.
    storage_optimizer_list: ?[]const StorageOptimizer = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .storage_optimizer_list = "StorageOptimizerList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTableStorageOptimizersInput, options: CallOptions) !ListTableStorageOptimizersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTableStorageOptimizersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListTableStorageOptimizers";

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
    if (input.storage_optimizer_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StorageOptimizerType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTableStorageOptimizersOutput {
    const result: ListTableStorageOptimizersOutput = try aws.json.parseJsonObject(
        ListTableStorageOptimizersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
