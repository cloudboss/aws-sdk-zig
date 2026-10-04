const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryCatalogDataInput = @import("repository_catalog_data_input.zig").RepositoryCatalogDataInput;
const RepositoryCatalogData = @import("repository_catalog_data.zig").RepositoryCatalogData;

pub const PutRepositoryCatalogDataInput = struct {
    /// An object containing the catalog data for a repository. This data is
    /// publicly visible in
    /// the Amazon ECR Public Gallery.
    catalog_data: RepositoryCatalogDataInput,

    /// The Amazon Web Services account ID that's associated with the public
    /// registry the repository is in.
    /// If you do not specify a registry, the default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository to create or update the catalog data for.
    repository_name: []const u8,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const PutRepositoryCatalogDataOutput = struct {
    /// The catalog data for the repository.
    catalog_data: ?RepositoryCatalogData = null,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRepositoryCatalogDataInput, options: CallOptions) !PutRepositoryCatalogDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr-public", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRepositoryCatalogDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.PutRepositoryCatalogData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRepositoryCatalogDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutRepositoryCatalogDataOutput, body, allocator);
}
