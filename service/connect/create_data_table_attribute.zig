const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Validation = @import("validation.zig").Validation;
const DataTableAttributeValueType = @import("data_table_attribute_value_type.zig").DataTableAttributeValueType;
const DataTableLockVersion = @import("data_table_lock_version.zig").DataTableLockVersion;

pub const CreateDataTableAttributeInput = struct {
    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias. If the
    /// version is provided as part of the identifier or ARN, the version must be
    /// one of the two available system managed
    /// aliases, $SAVED or $LATEST.
    data_table_id: []const u8,

    /// An optional description for the attribute. Must conform to Connect human
    /// readable string specification and have
    /// 0-250 characters. Whitespace trimmed before persisting.
    description: ?[]const u8 = null,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    /// The name for the attribute. Must conform to Connect human readable string
    /// specification and have 1-127
    /// characters. Must not start with the reserved case insensitive values
    /// 'connect:' and 'aws:'. Whitespace trimmed before
    /// persisting. Must be unique for the data table using case-insensitive
    /// comparison.
    name: []const u8,

    /// Optional boolean that defaults to false. Determines if the value is used to
    /// identify a record in the table.
    /// Values for primary attributes must not be expressions.
    primary: ?bool = null,

    /// Optional validation rules for the attribute. Borrows heavily from JSON
    /// Schema - Draft 2020-12. The maximum
    /// length of arrays within validations and depth of validations is 5. There are
    /// default limits that apply to all types.
    /// Customer specified limits in excess of the default limits are not permitted.
    validation: ?Validation = null,

    /// The type of value allowed or the resultant type after the value's expression
    /// is evaluated. Must be one of TEXT,
    /// TEXT_LIST, NUMBER, NUMBER_LIST, and BOOLEAN.
    value_type: DataTableAttributeValueType,

    pub const json_field_names = .{
        .data_table_id = "DataTableId",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .primary = "Primary",
        .validation = "Validation",
        .value_type = "ValueType",
    };
};

pub const CreateDataTableAttributeOutput = struct {
    /// The unique identifier assigned to the created attribute.
    attribute_id: ?[]const u8 = null,

    /// The lock version information for the data table and attribute, used for
    /// optimistic locking and
    /// versioning.
    lock_version: ?DataTableLockVersion = null,

    /// The name of the created attribute since it also serves as the identifier.
    /// This could be different than the
    /// parameter passed in since it will be trimmed for whitespace.
    name: []const u8,

    pub const json_field_names = .{
        .attribute_id = "AttributeId",
        .lock_version = "LockVersion",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataTableAttributeInput, options: CallOptions) !CreateDataTableAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataTableAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/attributes");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataTableAttributeOutput {
    const result: CreateDataTableAttributeOutput = try aws.json.parseJsonObject(
        CreateDataTableAttributeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
