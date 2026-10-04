const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EffectiveHoursOfOperations = @import("effective_hours_of_operations.zig").EffectiveHoursOfOperations;
const EffectiveOverrideHours = @import("effective_override_hours.zig").EffectiveOverrideHours;

pub const GetEffectiveHoursOfOperationsInput = struct {
    /// The date from when the hours of operation are listed.
    from_date: []const u8,

    /// The identifier for the hours of operation.
    hours_of_operation_id: []const u8,

    /// The identifier of the Connect Customer instance.
    instance_id: []const u8,

    /// The date until when the hours of operation are listed.
    to_date: []const u8,

    pub const json_field_names = .{
        .from_date = "FromDate",
        .hours_of_operation_id = "HoursOfOperationId",
        .instance_id = "InstanceId",
        .to_date = "ToDate",
    };
};

pub const GetEffectiveHoursOfOperationsOutput = struct {
    /// Information about the effective hours of operations.
    effective_hours_of_operation_list: ?[]const EffectiveHoursOfOperations = null,

    /// Information about override configurations applied to the base hours of
    /// operation to calculate the effective hours.
    ///
    /// For more information about how override types are applied, see [Build your
    /// list of
    /// overrides](https://docs.aws.amazon.com/connect/latest/adminguide/hours-of-operation-overrides.html) in the
    /// * Administrator Guide*.
    effective_override_hours_list: ?[]const EffectiveOverrideHours = null,

    /// The time zone for the hours of operation.
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .effective_hours_of_operation_list = "EffectiveHoursOfOperationList",
        .effective_override_hours_list = "EffectiveOverrideHoursList",
        .time_zone = "TimeZone",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEffectiveHoursOfOperationsInput, options: CallOptions) !GetEffectiveHoursOfOperationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEffectiveHoursOfOperationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/effective-hours-of-operations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.hours_of_operation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "fromDate=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.from_date);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "toDate=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.to_date);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEffectiveHoursOfOperationsOutput {
    const result: GetEffectiveHoursOfOperationsOutput = try aws.json.parseJsonObject(
        GetEffectiveHoursOfOperationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
