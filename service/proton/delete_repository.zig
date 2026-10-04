const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;
const Repository = @import("repository.zig").Repository;

pub const DeleteRepositoryInput = struct {
    /// The repository name.
    name: []const u8,

    /// The repository provider.
    provider: RepositoryProvider,

    pub const json_field_names = .{
        .name = "name",
        .provider = "provider",
    };
};

pub const DeleteRepositoryOutput = struct {
    /// The deleted repository link's detail data that's returned by Proton.
    repository: ?Repository = null,

    pub const json_field_names = .{
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRepositoryInput, options: CallOptions) !DeleteRepositoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRepositoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.DeleteRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteRepositoryOutput, body, allocator);
}
