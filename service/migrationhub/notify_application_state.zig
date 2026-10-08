const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const NotifyApplicationStateInput = struct {
    /// The configurationId in Application Discovery Service that uniquely
    /// identifies the
    /// grouped application.
    application_id: []const u8,

    /// Optional boolean flag to indicate whether any effect should take place. Used
    /// to test if
    /// the caller has permission to make the call.
    dry_run: ?bool = null,

    /// Status of the application - Not Started, In-Progress, Complete.
    status: ApplicationStatus,

    /// The timestamp when the application state changed.
    update_date_time: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .dry_run = "DryRun",
        .status = "Status",
        .update_date_time = "UpdateDateTime",
    };
};

pub const NotifyApplicationStateOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: NotifyApplicationStateInput, options: CallOptions) !NotifyApplicationStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: NotifyApplicationStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.NotifyApplicationState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !NotifyApplicationStateOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
