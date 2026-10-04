const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExclusionWindow = @import("exclusion_window.zig").ExclusionWindow;
const BatchUpdateExclusionWindowsError = @import("batch_update_exclusion_windows_error.zig").BatchUpdateExclusionWindowsError;

pub const BatchUpdateExclusionWindowsInput = struct {
    /// A list of exclusion windows to add to the specified SLOs. You can add up to
    /// 10 exclusion windows per SLO.
    add_exclusion_windows: ?[]const ExclusionWindow = null,

    /// A list of exclusion windows to remove from the specified SLOs. The window
    /// configuration must match an existing exclusion window.
    remove_exclusion_windows: ?[]const ExclusionWindow = null,

    /// The list of SLO IDs to add or remove exclusion windows from.
    slo_ids: []const []const u8,

    pub const json_field_names = .{
        .add_exclusion_windows = "AddExclusionWindows",
        .remove_exclusion_windows = "RemoveExclusionWindows",
        .slo_ids = "SloIds",
    };
};

pub const BatchUpdateExclusionWindowsOutput = struct {
    /// A list of errors that occurred while processing the request.
    errors: ?[]const BatchUpdateExclusionWindowsError = null,

    /// The list of SLO IDs that were successfully processed.
    slo_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .slo_ids = "SloIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateExclusionWindowsInput, options: CallOptions) !BatchUpdateExclusionWindowsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateExclusionWindowsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exclusion-windows";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.add_exclusion_windows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AddExclusionWindows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_exclusion_windows) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RemoveExclusionWindows\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SloIds\":");
    try aws.json.writeValue(@TypeOf(input.slo_ids), input.slo_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateExclusionWindowsOutput {
    var result: BatchUpdateExclusionWindowsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateExclusionWindowsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
