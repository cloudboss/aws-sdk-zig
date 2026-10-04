const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceState = @import("service_state.zig").ServiceState;

pub const DeleteServiceInput = struct {
    /// Deletes a Refactor Spaces service.
    ///
    /// The `RefactorSpacesSecurityGroup` security group must be removed from all
    /// Amazon Web Services resources in the virtual private cloud (VPC) prior to
    /// deleting a service with a URL
    /// endpoint in a VPC.
    application_identifier: []const u8,

    /// The ID of the environment that the service is in.
    environment_identifier: []const u8,

    /// The ID of the service to delete.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .service_identifier = "ServiceIdentifier",
    };
};

pub const DeleteServiceOutput = struct {
    /// The ID of the application that the service is in.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// A timestamp that indicates when the service was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// The unique identifier of the service.
    service_id: ?[]const u8 = null,

    /// The current state of the service.
    state: ?ServiceState = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .service_id = "ServiceId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteServiceInput, options: CallOptions) !DeleteServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "refactor-spaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteServiceOutput {
    var result: DeleteServiceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteServiceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
