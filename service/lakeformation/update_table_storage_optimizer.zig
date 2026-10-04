const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateTableStorageOptimizerInput = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8 = null,

    /// Name of the database where the table is present.
    database_name: []const u8,

    /// Name of the configuration for the storage optimizer.
    storage_optimizer_config: []const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// Name of the table for which to enable the storage optimizer.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .storage_optimizer_config = "StorageOptimizerConfig",
        .table_name = "TableName",
    };
};

pub const UpdateTableStorageOptimizerOutput = struct {
    /// A response indicating the success of failure of the operation.
    result: ?[]const u8 = null,

    pub const json_field_names = .{
        .result = "Result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableStorageOptimizerInput, options: CallOptions) !UpdateTableStorageOptimizerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableStorageOptimizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateTableStorageOptimizer";

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
    try body_buf.appendSlice(allocator, "\"StorageOptimizerConfig\":");
    try aws.json.writeValue(@TypeOf(input.storage_optimizer_config), input.storage_optimizer_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableStorageOptimizerOutput {
    var result: UpdateTableStorageOptimizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateTableStorageOptimizerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
