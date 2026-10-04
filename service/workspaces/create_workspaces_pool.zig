const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationSettingsRequest = @import("application_settings_request.zig").ApplicationSettingsRequest;
const Capacity = @import("capacity.zig").Capacity;
const PoolsRunningMode = @import("pools_running_mode.zig").PoolsRunningMode;
const Tag = @import("tag.zig").Tag;
const TimeoutSettings = @import("timeout_settings.zig").TimeoutSettings;
const WorkspacesPool = @import("workspaces_pool.zig").WorkspacesPool;

pub const CreateWorkspacesPoolInput = struct {
    /// Indicates the application settings of the pool.
    application_settings: ?ApplicationSettingsRequest = null,

    /// The identifier of the bundle for the pool.
    bundle_id: []const u8,

    /// The user capacity of the pool.
    capacity: Capacity,

    /// The pool description.
    description: []const u8,

    /// The identifier of the directory for the pool.
    directory_id: []const u8,

    /// The name of the pool.
    pool_name: []const u8,

    /// The running mode for the pool.
    running_mode: ?PoolsRunningMode = null,

    /// The tags for the pool.
    tags: ?[]const Tag = null,

    /// Indicates the timeout settings of the pool.
    timeout_settings: ?TimeoutSettings = null,

    pub const json_field_names = .{
        .application_settings = "ApplicationSettings",
        .bundle_id = "BundleId",
        .capacity = "Capacity",
        .description = "Description",
        .directory_id = "DirectoryId",
        .pool_name = "PoolName",
        .running_mode = "RunningMode",
        .tags = "Tags",
        .timeout_settings = "TimeoutSettings",
    };
};

pub const CreateWorkspacesPoolOutput = struct {
    /// Indicates the pool to create.
    workspaces_pool: ?WorkspacesPool = null,

    pub const json_field_names = .{
        .workspaces_pool = "WorkspacesPool",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspacesPoolInput, options: CallOptions) !CreateWorkspacesPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspacesPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateWorkspacesPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspacesPoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkspacesPoolOutput, body, allocator);
}
