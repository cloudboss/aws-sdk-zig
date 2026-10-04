const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CatalogInput = @import("catalog_input.zig").CatalogInput;

pub const CreateCatalogInput = struct {
    /// A `CatalogInput` object that defines the metadata for the catalog.
    catalog_input: CatalogInput,

    /// The name of the catalog to create.
    name: []const u8,

    /// A map array of key-value pairs, not more than 50 pairs. Each key is a UTF-8
    /// string, not less than 1 or more than 128 bytes long. Each value is a UTF-8
    /// string, not more than 256 bytes long. The tags you assign to the catalog.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .catalog_input = "CatalogInput",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateCatalogOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCatalogInput, options: CallOptions) !CreateCatalogOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCatalogInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateCatalog");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCatalogOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
