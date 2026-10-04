const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HoursOfOperationConfig = @import("hours_of_operation_config.zig").HoursOfOperationConfig;
const ParentHoursOfOperationConfig = @import("parent_hours_of_operation_config.zig").ParentHoursOfOperationConfig;

pub const CreateHoursOfOperationInput = struct {
    /// Configuration information for the hours of operation: day, start time, and
    /// end time.
    config: []const HoursOfOperationConfig,

    /// The description of the hours of operation.
    description: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name of the hours of operation.
    name: []const u8,

    /// Configuration for parent hours of operations. Eg: ResourceArn.
    ///
    /// For more information about parent hours of operations, see [Link overrides
    /// from different hours of
    /// operation](https://docs.aws.amazon.com/connect/latest/adminguide/hours-of-operation-overrides.html) in the
    /// * Administrator Guide*.
    parent_hours_of_operation_configs: ?[]const ParentHoursOfOperationConfig = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone of the hours of operation.
    time_zone: []const u8,

    pub const json_field_names = .{
        .config = "Config",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .parent_hours_of_operation_configs = "ParentHoursOfOperationConfigs",
        .tags = "Tags",
        .time_zone = "TimeZone",
    };
};

pub const CreateHoursOfOperationOutput = struct {
    /// The Amazon Resource Name (ARN) for the hours of operation.
    hours_of_operation_arn: ?[]const u8 = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .hours_of_operation_arn = "HoursOfOperationArn",
        .hours_of_operation_id = "HoursOfOperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHoursOfOperationInput, options: CallOptions) !CreateHoursOfOperationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHoursOfOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hours-of-operations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Config\":");
    try aws.json.writeValue(@TypeOf(input.config), input.config, allocator, &body_buf);
    has_prev = true;
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
    if (input.parent_hours_of_operation_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentHoursOfOperationConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHoursOfOperationOutput {
    const result: CreateHoursOfOperationOutput = try aws.json.parseJsonObject(
        CreateHoursOfOperationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
