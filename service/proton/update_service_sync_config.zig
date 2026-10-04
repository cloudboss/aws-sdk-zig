const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;
const ServiceSyncConfig = @import("service_sync_config.zig").ServiceSyncConfig;

pub const UpdateServiceSyncConfigInput = struct {
    /// The name of the code repository branch where the Proton Ops file is found.
    branch: []const u8,

    /// The path to the Proton Ops file.
    file_path: []const u8,

    /// The name of the repository where the Proton Ops file is found.
    repository_name: []const u8,

    /// The name of the repository provider where the Proton Ops file is found.
    repository_provider: RepositoryProvider,

    /// The name of the service the Proton Ops file is for.
    service_name: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .file_path = "filePath",
        .repository_name = "repositoryName",
        .repository_provider = "repositoryProvider",
        .service_name = "serviceName",
    };
};

pub const UpdateServiceSyncConfigOutput = struct {
    /// The detailed data of the Proton Ops file.
    service_sync_config: ?ServiceSyncConfig = null,

    pub const json_field_names = .{
        .service_sync_config = "serviceSyncConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceSyncConfigInput, options: CallOptions) !UpdateServiceSyncConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceSyncConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateServiceSyncConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceSyncConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateServiceSyncConfigOutput, body, allocator);
}
