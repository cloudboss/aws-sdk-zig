const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableValue = @import("data_table_value.zig").DataTableValue;
const BatchCreateDataTableValueFailureResult = @import("batch_create_data_table_value_failure_result.zig").BatchCreateDataTableValueFailureResult;
const BatchCreateDataTableValueSuccessResult = @import("batch_create_data_table_value_success_result.zig").BatchCreateDataTableValueSuccessResult;

pub const BatchCreateDataTableValueInput = struct {
    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias. If no
    /// alias is provided, the default behavior is identical to providing the
    /// $LATEST alias.
    data_table_id: []const u8,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// A list of values to create. Each value must specify the attribute name and
    /// optionally primary values if the
    /// table has primary attributes.
    values: []const DataTableValue,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .instance_id = "InstanceId",
        .values = "Values",
    };
};

pub const BatchCreateDataTableValueOutput = struct {
    /// A list of values that failed to be created with error messages explaining
    /// the failure reason.
    failed: ?[]const BatchCreateDataTableValueFailureResult = null,

    /// A list of successfully created values with their identifiers and lock
    /// versions.
    successful: ?[]const BatchCreateDataTableValueSuccessResult = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateDataTableValueInput, options: CallOptions) !BatchCreateDataTableValueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateDataTableValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/values/create");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateDataTableValueOutput {
    const result: BatchCreateDataTableValueOutput = try aws.json.parseJsonObject(
        BatchCreateDataTableValueOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
