const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryScanningConfigurationFailure = @import("repository_scanning_configuration_failure.zig").RepositoryScanningConfigurationFailure;
const RepositoryScanningConfiguration = @import("repository_scanning_configuration.zig").RepositoryScanningConfiguration;

pub const BatchGetRepositoryScanningConfigurationInput = struct {
    /// One or more repository names to get the scanning configuration for.
    repository_names: []const []const u8,

    pub const json_field_names = .{
        .repository_names = "repositoryNames",
    };
};

pub const BatchGetRepositoryScanningConfigurationOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const RepositoryScanningConfigurationFailure = null,

    /// The scanning configuration for the requested repositories.
    scanning_configurations: ?[]const RepositoryScanningConfiguration = null,

    pub const json_field_names = .{
        .failures = "failures",
        .scanning_configurations = "scanningConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetRepositoryScanningConfigurationInput, options: CallOptions) !BatchGetRepositoryScanningConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetRepositoryScanningConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.BatchGetRepositoryScanningConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetRepositoryScanningConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetRepositoryScanningConfigurationOutput, body, allocator);
}
