const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HoursOfOperationOverrideConfig = @import("hours_of_operation_override_config.zig").HoursOfOperationOverrideConfig;
const OverrideType = @import("override_type.zig").OverrideType;
const RecurrenceConfig = @import("recurrence_config.zig").RecurrenceConfig;

pub const CreateHoursOfOperationOverrideInput = struct {
    /// Configuration information for the hours of operation override: day, start
    /// time, and end time.
    config: []const HoursOfOperationOverrideConfig,

    /// The description of the hours of operation override.
    description: ?[]const u8 = null,

    /// The date from when the hours of operation override is effective.
    effective_from: []const u8,

    /// The date until when the hours of operation override is effective.
    effective_till: []const u8,

    /// The identifier for the hours of operation
    hours_of_operation_id: []const u8,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The name of the hours of operation override.
    name: []const u8,

    /// Whether the override will be defined as a *standard* or as a *recurring
    /// event*.
    ///
    /// For more information about how override types are applied, see [Build your
    /// list of
    /// overrides](https://docs.aws.amazon.com/https:/docs.aws.amazon.com/connect/latest/adminguide/hours-of-operation-overrides.html) in the
    /// * Administrator Guide*.
    override_type: ?OverrideType = null,

    /// Configuration for a recurring event.
    recurrence_config: ?RecurrenceConfig = null,

    pub const json_field_names = .{
        .config = "Config",
        .description = "Description",
        .effective_from = "EffectiveFrom",
        .effective_till = "EffectiveTill",
        .hours_of_operation_id = "HoursOfOperationId",
        .instance_id = "InstanceId",
        .name = "Name",
        .override_type = "OverrideType",
        .recurrence_config = "RecurrenceConfig",
    };
};

pub const CreateHoursOfOperationOverrideOutput = struct {
    /// The identifier for the hours of operation override.
    hours_of_operation_override_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .hours_of_operation_override_id = "HoursOfOperationOverrideId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHoursOfOperationOverrideInput, options: CallOptions) !CreateHoursOfOperationOverrideOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHoursOfOperationOverrideInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hours-of-operations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.hours_of_operation_id);
    try path_buf.appendSlice(allocator, "/overrides");
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
    try body_buf.appendSlice(allocator, "\"EffectiveFrom\":");
    try aws.json.writeValue(@TypeOf(input.effective_from), input.effective_from, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EffectiveTill\":");
    try aws.json.writeValue(@TypeOf(input.effective_till), input.effective_till, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.override_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OverrideType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recurrence_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecurrenceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHoursOfOperationOverrideOutput {
    var result: CreateHoursOfOperationOverrideOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateHoursOfOperationOverrideOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
