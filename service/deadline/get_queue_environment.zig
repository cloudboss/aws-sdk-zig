const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentTemplateType = @import("environment_template_type.zig").EnvironmentTemplateType;

pub const GetQueueEnvironmentInput = struct {
    /// The farm ID for the queue environment.
    farm_id: []const u8,

    /// The queue environment ID.
    queue_environment_id: []const u8,

    /// The queue ID for the queue environment.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .queue_environment_id = "queueEnvironmentId",
        .queue_id = "queueId",
    };
};

pub const GetQueueEnvironmentOutput = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.>
    created_by: []const u8,

    /// The name of the queue environment.
    name: []const u8,

    /// The priority of the queue environment.
    priority: i32,

    /// The queue environment ID.
    queue_environment_id: []const u8,

    /// The template for the queue environment.
    template: []const u8,

    /// The type of template for the queue environment.
    template_type: EnvironmentTemplateType,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .name = "name",
        .priority = "priority",
        .queue_environment_id = "queueEnvironmentId",
        .template = "template",
        .template_type = "templateType",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueEnvironmentInput, options: CallOptions) !GetQueueEnvironmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.queue_environment_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueEnvironmentOutput {
    const result: GetQueueEnvironmentOutput = try aws.json.parseJsonObject(
        GetQueueEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
