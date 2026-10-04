const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableDeleteValueIdentifier = @import("data_table_delete_value_identifier.zig").DataTableDeleteValueIdentifier;
const BatchDeleteDataTableValueFailureResult = @import("batch_delete_data_table_value_failure_result.zig").BatchDeleteDataTableValueFailureResult;
const BatchDeleteDataTableValueSuccessResult = @import("batch_delete_data_table_value_success_result.zig").BatchDeleteDataTableValueSuccessResult;

pub const BatchDeleteDataTableValueInput = struct {
    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias.
    data_table_id: []const u8,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// A list of value identifiers to delete, each specifying primary values,
    /// attribute name, and lock version
    /// information.
    values: []const DataTableDeleteValueIdentifier,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .instance_id = "InstanceId",
        .values = "Values",
    };
};

pub const BatchDeleteDataTableValueOutput = struct {
    /// A list of values that failed to be deleted with error messages explaining
    /// the failure reason.
    failed: ?[]const BatchDeleteDataTableValueFailureResult = null,

    /// A list of successfully deleted values with their identifiers and updated
    /// lock versions.
    successful: ?[]const BatchDeleteDataTableValueSuccessResult = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDataTableValueInput, options: CallOptions) !BatchDeleteDataTableValueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDataTableValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/values/delete");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Values\":");
    try aws.json.writeValue(@TypeOf(input.values), input.values, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDataTableValueOutput {
    const result: BatchDeleteDataTableValueOutput = try aws.json.parseJsonObject(
        BatchDeleteDataTableValueOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
