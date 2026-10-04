const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EMRContainersConfig = @import("emr_containers_config.zig").EMRContainersConfig;
const ProfilerType = @import("profiler_type.zig").ProfilerType;
const Tag = @import("tag.zig").Tag;

pub const CreatePersistentAppUIInput = struct {
    /// The EMR containers configuration.
    emr_containers_config: ?EMRContainersConfig = null,

    /// The profiler type for the persistent application user interface.
    profiler_type: ?ProfilerType = null,

    /// Tags for the persistent application user interface.
    tags: ?[]const Tag = null,

    /// The unique Amazon Resource Name (ARN) of the target resource.
    target_resource_arn: []const u8,

    /// The cross reference for the persistent application user interface.
    x_referer: ?[]const u8 = null,

    pub const json_field_names = .{
        .emr_containers_config = "EMRContainersConfig",
        .profiler_type = "ProfilerType",
        .tags = "Tags",
        .target_resource_arn = "TargetResourceArn",
        .x_referer = "XReferer",
    };
};

pub const CreatePersistentAppUIOutput = struct {
    /// The persistent application user interface identifier.
    persistent_app_ui_id: ?[]const u8 = null,

    /// Represents if the EMR on EC2 cluster that the persisent application user
    /// interface is created for is a runtime role
    /// enabled cluster or not.
    runtime_role_enabled_cluster: ?bool = null,

    pub const json_field_names = .{
        .persistent_app_ui_id = "PersistentAppUIId",
        .runtime_role_enabled_cluster = "RuntimeRoleEnabledCluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePersistentAppUIInput, options: CallOptions) !CreatePersistentAppUIOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePersistentAppUIInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CreatePersistentAppUI");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePersistentAppUIOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePersistentAppUIOutput, body, allocator);
}
