const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HoursOfOperationOverrideConfig = @import("hours_of_operation_override_config.zig").HoursOfOperationOverrideConfig;
const OverrideType = @import("override_type.zig").OverrideType;
const RecurrenceConfig = @import("recurrence_config.zig").RecurrenceConfig;

pub const UpdateHoursOfOperationOverrideInput = struct {
    /// Configuration information for the hours of operation override: day, start
    /// time, and end time.
    config: ?[]const HoursOfOperationOverrideConfig = null,

    /// The description of the hours of operation override.
    description: ?[]const u8 = null,

    /// The date from when the hours of operation override would be effective.
    effective_from: ?[]const u8 = null,

    /// The date until the hours of operation override is effective.
    effective_till: ?[]const u8 = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: []const u8,

    /// The identifier for the hours of operation override.
    hours_of_operation_override_id: []const u8,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The name of the hours of operation override.
    name: ?[]const u8 = null,

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
        .hours_of_operation_override_id = "HoursOfOperationOverrideId",
        .instance_id = "InstanceId",
        .name = "Name",
        .override_type = "OverrideType",
        .recurrence_config = "RecurrenceConfig",
    };
};

pub const UpdateHoursOfOperationOverrideOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHoursOfOperationOverrideInput, options: CallOptions) !UpdateHoursOfOperationOverrideOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHoursOfOperationOverrideInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hours-of-operations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.hours_of_operation_id);
    try path_buf.appendSlice(allocator, "/overrides/");
    try path_buf.appendSlice(allocator, input.hours_of_operation_override_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Config\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.effective_from) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EffectiveFrom\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.effective_till) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EffectiveTill\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHoursOfOperationOverrideOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateHoursOfOperationOverrideOutput = .{};

    return result;
}
