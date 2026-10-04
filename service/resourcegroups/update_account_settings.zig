const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupLifecycleEventsDesiredStatus = @import("group_lifecycle_events_desired_status.zig").GroupLifecycleEventsDesiredStatus;
const AccountSettings = @import("account_settings.zig").AccountSettings;

pub const UpdateAccountSettingsInput = struct {
    /// Specifies whether you want to turn [group lifecycle
    /// events](https://docs.aws.amazon.com/ARG/latest/userguide/monitor-groups.html) on or off.
    ///
    /// You can't turn on group lifecycle events if your resource groups quota is
    /// greater than 2,000.
    group_lifecycle_events_desired_status: ?GroupLifecycleEventsDesiredStatus = null,

    pub const json_field_names = .{
        .group_lifecycle_events_desired_status = "GroupLifecycleEventsDesiredStatus",
    };
};

pub const UpdateAccountSettingsOutput = struct {
    /// A structure that displays the status of the optional features in the
    /// account.
    account_settings: ?AccountSettings = null,

    pub const json_field_names = .{
        .account_settings = "AccountSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, options: CallOptions) !UpdateAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-account-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.group_lifecycle_events_desired_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupLifecycleEventsDesiredStatus\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountSettingsOutput {
    var result: UpdateAccountSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAccountSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
