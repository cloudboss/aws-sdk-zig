const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;
const PrimaryValue = @import("primary_value.zig").PrimaryValue;

pub const UpdateDataTablePrimaryValuesInput = struct {
    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias. If the
    /// version is provided as part of the identifier or ARN, the version must be
    /// one of the two available system managed
    /// aliases, $SAVED or $LATEST.
    data_table_id: []const u8,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// The lock version information required for optimistic locking to prevent
    /// concurrent modifications.
    lock_version: DataTableLockVersion,

    /// The new primary values for the record. Required and must include values for
    /// all primary attributes. The
    /// combination must be unique within the table.
    new_primary_values: []const PrimaryValue,

    /// The current primary values for the record. Required and must include values
    /// for all primary attributes. Fails if
    /// the table has primary attributes and some primary values are omitted.
    primary_values: []const PrimaryValue,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .instance_id = "InstanceId",
        .lock_version = "LockVersion",
        .new_primary_values = "NewPrimaryValues",
        .primary_values = "PrimaryValues",
    };
};

pub const UpdateDataTablePrimaryValuesOutput = struct {
    /// The updated lock version information for the data table and affected
    /// components after the primary values
    /// change.
    lock_version: ?DataTableLockVersion = null,

    pub const json_field_names = .{
        .lock_version = "LockVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataTablePrimaryValuesInput, options: CallOptions) !UpdateDataTablePrimaryValuesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataTablePrimaryValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/values/update-primary");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LockVersion\":");
    try aws.json.writeValue(@TypeOf(input.lock_version), input.lock_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NewPrimaryValues\":");
    try aws.json.writeValue(@TypeOf(input.new_primary_values), input.new_primary_values, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrimaryValues\":");
    try aws.json.writeValue(@TypeOf(input.primary_values), input.primary_values, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataTablePrimaryValuesOutput {
    const result: UpdateDataTablePrimaryValuesOutput = try aws.json.parseJsonObject(
        UpdateDataTablePrimaryValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
