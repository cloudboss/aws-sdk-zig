const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisableControlInput = struct {
    /// The ARN of the control. Only **Strongly recommended** and **Elective**
    /// controls are permitted, with the exception of the **Region deny** control.
    /// For information on how to find the `controlIdentifier`, see [the overview
    /// page](https://docs.aws.amazon.com/controltower/latest/APIReference/Welcome.html).
    control_identifier: ?[]const u8 = null,

    /// The ARN of the enabled control to be disabled, which uniquely identifies the
    /// control instance on the target organizational unit.
    enabled_control_identifier: ?[]const u8 = null,

    /// The ARN of the organizational unit. For information on how to find the
    /// `targetIdentifier`, see [the overview
    /// page](https://docs.aws.amazon.com/controltower/latest/APIReference/Welcome.html).
    target_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .control_identifier = "controlIdentifier",
        .enabled_control_identifier = "enabledControlIdentifier",
        .target_identifier = "targetIdentifier",
    };
};

pub const DisableControlOutput = struct {
    /// The ID of the asynchronous operation, which is used to track status. The
    /// operation is available for 90 days.
    operation_identifier: []const u8,

    pub const json_field_names = .{
        .operation_identifier = "operationIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableControlInput, options: CallOptions) !DisableControlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controltower", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/disable-control";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.control_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"controlIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enabled_control_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enabledControlIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableControlOutput {
    const result: DisableControlOutput = try aws.json.parseJsonObject(
        DisableControlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
