const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableStatus = @import("data_table_status.zig").DataTableStatus;
const DataTableLockLevel = @import("data_table_lock_level.zig").DataTableLockLevel;
const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;

pub const CreateDataTableInput = struct {
    /// An optional description for the data table. Must conform to Connect human
    /// readable string specification and have
    /// 0-250 characters. Whitespace must be trimmed first.
    description: ?[]const u8 = null,

    /// The unique identifier for the Amazon Connect instance where the data table
    /// will be created.
    instance_id: []const u8,

    /// The name for the data table. Must conform to Connect human readable string
    /// specification and have 1-127
    /// characters. Whitespace must be trimmed first. Must not start with the
    /// reserved case insensitive values 'connect:' and
    /// 'aws:'. Must be unique for the instance using case-insensitive comparison.
    name: []const u8,

    /// The status of the data table. One of PUBLISHED or SAVED. Required parameter
    /// that determines the initial state of
    /// the table.
    status: DataTableStatus,

    /// Key value pairs for attribute based access control (TBAC or ABAC). Optional
    /// tags to apply to the data table for
    /// organization and access control purposes.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The IANA timezone identifier to use when resolving time based dynamic
    /// values. Required even if no time slices
    /// are specified.
    time_zone: []const u8,

    /// The data level that concurrent value edits are locked on. One of DATA_TABLE,
    /// PRIMARY_VALUE, ATTRIBUTE, VALUE,
    /// and NONE. NONE is the default if unspecified. This determines how concurrent
    /// edits are handled when multiple users
    /// attempt to modify values simultaneously.
    value_lock_level: DataTableLockLevel,

    pub const json_field_names = .{
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .time_zone = "TimeZone",
        .value_lock_level = "ValueLockLevel",
    };
};

pub const CreateDataTableOutput = struct {
    /// The Amazon Resource Name (ARN) for the created data table. Does not include
    /// the version alias.
    arn: []const u8,

    /// The unique identifier for the created data table. Does not include the
    /// version alias.
    id: []const u8,

    /// The lock version information for the created data table, used for optimistic
    /// locking and table
    /// versioning.
    lock_version: ?DataTableLockVersion = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .lock_version = "LockVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataTableInput, options: CallOptions) !CreateDataTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
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
    try body_buf.appendSlice(allocator, "\"Status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataTableOutput {
    var result: CreateDataTableOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataTableOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
