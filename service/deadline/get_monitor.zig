const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMonitorInput = struct {
    /// The unique identifier for the monitor. This ID is returned by the
    /// `CreateMonitor` operation.
    monitor_id: []const u8,

    pub const json_field_names = .{
        .monitor_id = "monitorId",
    };
};

pub const GetMonitorOutput = struct {
    /// The UNIX timestamp of the date and time that the monitor was created.
    created_at: i64,

    /// The user name of the person that created the monitor.
    created_by: []const u8,

    /// The name used to identify the monitor on the Deadline Cloud console.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The Amazon Resource Name that the IAM Identity Center assigned to the
    /// monitor when it was created.
    identity_center_application_arn: []const u8,

    /// The Amazon Resource Name of the IAM Identity Center instance responsible for
    /// authenticating monitor users.
    identity_center_instance_arn: []const u8,

    /// The Region where IAM Identity Center is enabled.
    identity_center_region: ?[]const u8 = null,

    /// The unique identifier for the monitor.
    monitor_id: []const u8,

    /// The Amazon Resource Name of the IAM role for the monitor. Users of the
    /// monitor use this role to access Deadline Cloud resources.
    role_arn: []const u8,

    /// The subdomain used for the monitor URL. The full URL of the monitor is
    /// subdomain.Region.deadlinecloud.amazonaws.com.
    subdomain: []const u8,

    /// The UNIX timestamp of the last date and time that the monitor was updated.
    updated_at: ?i64 = null,

    /// The user name of the person that last updated the monitor.
    updated_by: ?[]const u8 = null,

    /// The complete URL of the monitor. The full URL of the monitor is
    /// subdomain.Region.deadlinecloud.amazonaws.com.
    url: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .display_name = "displayName",
        .identity_center_application_arn = "identityCenterApplicationArn",
        .identity_center_instance_arn = "identityCenterInstanceArn",
        .identity_center_region = "identityCenterRegion",
        .monitor_id = "monitorId",
        .role_arn = "roleArn",
        .subdomain = "subdomain",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .url = "url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMonitorInput, options: CallOptions) !GetMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMonitorOutput {
    const result: GetMonitorOutput = try aws.json.parseJsonObject(
        GetMonitorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
