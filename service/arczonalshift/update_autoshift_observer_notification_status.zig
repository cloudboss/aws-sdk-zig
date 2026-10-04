const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoshiftObserverNotificationStatus = @import("autoshift_observer_notification_status.zig").AutoshiftObserverNotificationStatus;

pub const UpdateAutoshiftObserverNotificationStatusInput = struct {
    /// The status to set for autoshift observer notification. If the status is
    /// `ENABLED`, ARC includes all autoshift events when you use the Amazon
    /// EventBridge pattern `Autoshift In Progress`. When the status is `DISABLED`,
    /// ARC includes only autoshift events for autoshifts when one or more of your
    /// resources is included in the autoshift.
    status: AutoshiftObserverNotificationStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub const UpdateAutoshiftObserverNotificationStatusOutput = struct {
    /// The status for autoshift observer notification.
    status: AutoshiftObserverNotificationStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutoshiftObserverNotificationStatusInput, options: CallOptions) !UpdateAutoshiftObserverNotificationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "percdataplane", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutoshiftObserverNotificationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/autoshift-observer-notification";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutoshiftObserverNotificationStatusOutput {
    var result: UpdateAutoshiftObserverNotificationStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAutoshiftObserverNotificationStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
