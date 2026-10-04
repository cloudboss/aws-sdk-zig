const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Validation = @import("validation.zig").Validation;
const DataTableAttributeValueType = @import("data_table_attribute_value_type.zig").DataTableAttributeValueType;
const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;

pub const UpdateDataTableAttributeInput = struct {
    /// The current name of the attribute to update. Used as an identifier since
    /// attribute names can be changed.
    attribute_name: []const u8,

    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias.
    data_table_id: []const u8,

    /// The updated description for the attribute.
    description: ?[]const u8 = null,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// The new name for the attribute. Must conform to Connect human readable
    /// string specification and be unique within
    /// the data table.
    name: []const u8,

    /// Whether the attribute should be treated as a primary key. Converting to
    /// primary attribute requires existing
    /// values to maintain uniqueness.
    primary: ?bool = null,

    /// The updated validation rules for the attribute. Changes do not affect
    /// existing values until they are
    /// modified.
    validation: ?Validation = null,

    /// The updated value type for the attribute. When changing value types,
    /// existing values are not deleted but may
    /// return default values if incompatible.
    value_type: DataTableAttributeValueType,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .data_table_id = "DataTableId",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .primary = "Primary",
        .validation = "Validation",
        .value_type = "ValueType",
    };
};

pub const UpdateDataTableAttributeOutput = struct {
    /// The new lock version for the attribute after the update.
    lock_version: ?DataTableLockVersion = null,

    /// The trimmed name and identifier for the updated attribute.
    name: []const u8,

    pub const json_field_names = .{
        .lock_version = "LockVersion",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataTableAttributeInput, options: CallOptions) !UpdateDataTableAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataTableAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/attributes/");
    try path_buf.appendSlice(allocator, input.attribute_name);
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
    if (input.primary) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Primary\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Validation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ValueType\":");
    try aws.json.writeValue(@TypeOf(input.value_type), input.value_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataTableAttributeOutput {
    const result: UpdateDataTableAttributeOutput = try aws.json.parseJsonObject(
        UpdateDataTableAttributeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
