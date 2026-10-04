const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationInstanceHealthStatus = @import("application_instance_health_status.zig").ApplicationInstanceHealthStatus;
const ReportedRuntimeContextState = @import("reported_runtime_context_state.zig").ReportedRuntimeContextState;
const ApplicationInstanceStatus = @import("application_instance_status.zig").ApplicationInstanceStatus;

pub const DescribeApplicationInstanceInput = struct {
    /// The application instance's ID.
    application_instance_id: []const u8,

    pub const json_field_names = .{
        .application_instance_id = "ApplicationInstanceId",
    };
};

pub const DescribeApplicationInstanceOutput = struct {
    /// The application instance's ID.
    application_instance_id: ?[]const u8 = null,

    /// The ID of the application instance that this instance replaced.
    application_instance_id_to_replace: ?[]const u8 = null,

    /// The application instance's ARN.
    arn: ?[]const u8 = null,

    /// When the application instance was created.
    created_time: ?i64 = null,

    /// The device's ID.
    default_runtime_context_device: ?[]const u8 = null,

    /// The device's bane.
    default_runtime_context_device_name: ?[]const u8 = null,

    /// The application instance's description.
    description: ?[]const u8 = null,

    /// The application instance's health status.
    health_status: ?ApplicationInstanceHealthStatus = null,

    /// The application instance was updated.
    last_updated_time: ?i64 = null,

    /// The application instance's name.
    name: ?[]const u8 = null,

    /// The application instance's state.
    runtime_context_states: ?[]const ReportedRuntimeContextState = null,

    /// The application instance's runtime role ARN.
    runtime_role_arn: ?[]const u8 = null,

    /// The application instance's status.
    status: ?ApplicationInstanceStatus = null,

    /// The application instance's status description.
    status_description: ?[]const u8 = null,

    /// The application instance's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_instance_id = "ApplicationInstanceId",
        .application_instance_id_to_replace = "ApplicationInstanceIdToReplace",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .default_runtime_context_device = "DefaultRuntimeContextDevice",
        .default_runtime_context_device_name = "DefaultRuntimeContextDeviceName",
        .description = "Description",
        .health_status = "HealthStatus",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .runtime_context_states = "RuntimeContextStates",
        .runtime_role_arn = "RuntimeRoleArn",
        .status = "Status",
        .status_description = "StatusDescription",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationInstanceInput, options: CallOptions) !DescribeApplicationInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/application-instances/");
    try path_buf.appendSlice(allocator, input.application_instance_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationInstanceOutput {
    var result: DescribeApplicationInstanceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeApplicationInstanceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
