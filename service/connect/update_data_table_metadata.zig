const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableLockLevel = @import("data_table_lock_level.zig").DataTableLockLevel;
const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;

pub const UpdateDataTableMetadataInput = struct {
    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias. If the
    /// version is provided as part of the identifier or ARN, the version must be
    /// $LATEST. Providing any other alias fails
    /// with an error.
    data_table_id: []const u8,

    /// The updated description for the data table. Must conform to Connect human
    /// readable string specification and have
    /// 0-250 characters.
    description: ?[]const u8 = null,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// The updated name for the data table. Must conform to Connect human readable
    /// string specification and have 1-127
    /// characters. Must be unique for the instance using case-insensitive
    /// comparison.
    name: []const u8,

    /// The updated IANA timezone identifier to use when resolving time based
    /// dynamic values.
    time_zone: []const u8,

    /// The updated value lock level for the data table. One of DATA_TABLE,
    /// PRIMARY_VALUE, ATTRIBUTE, VALUE, and
    /// NONE.
    value_lock_level: DataTableLockLevel,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .time_zone = "TimeZone",
        .value_lock_level = "ValueLockLevel",
    };
};

pub const UpdateDataTableMetadataOutput = struct {
    /// The new lock version for the data table after the update.
    lock_version: ?DataTableLockVersion = null,

    pub const json_field_names = .{
        .lock_version = "LockVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataTableMetadataInput, options: CallOptions) !UpdateDataTableMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataTableMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TimeZone\":");
    try aws.json.writeValue(@TypeOf(input.time_zone), input.time_zone, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ValueLockLevel\":");
    try aws.json.writeValue(@TypeOf(input.value_lock_level), input.value_lock_level, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataTableMetadataOutput {
    const result: UpdateDataTableMetadataOutput = try aws.json.parseJsonObject(
        UpdateDataTableMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
