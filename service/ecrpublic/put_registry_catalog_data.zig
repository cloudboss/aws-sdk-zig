const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryCatalogData = @import("registry_catalog_data.zig").RegistryCatalogData;

pub const PutRegistryCatalogDataInput = struct {
    /// The display name for a public registry. The display name is shown as the
    /// repository
    /// author in the Amazon ECR Public Gallery.
    ///
    /// The registry display name is only publicly visible in the Amazon ECR Public
    /// Gallery for
    /// verified accounts.
    display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
    };
};

pub const PutRegistryCatalogDataOutput = struct {
    /// The catalog data for the public registry.
    registry_catalog_data: ?RegistryCatalogData = null,

    pub const json_field_names = .{
        .registry_catalog_data = "registryCatalogData",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRegistryCatalogDataInput, options: CallOptions) !PutRegistryCatalogDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRegistryCatalogDataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.PutRegistryCatalogData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRegistryCatalogDataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutRegistryCatalogDataOutput, body, allocator);
}
