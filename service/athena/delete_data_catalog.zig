const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataCatalog = @import("data_catalog.zig").DataCatalog;

pub const DeleteDataCatalogInput = struct {
    /// Deletes the Athena Data Catalog. You can only use this with the `FEDERATED`
    /// catalogs. You usually perform this before registering the connector with
    /// Glue Data
    /// Catalog. After deletion, you will have to manage the Glue Connection and
    /// Lambda
    /// function.
    delete_catalog_only: ?bool = null,

    /// The name of the data catalog to delete.
    name: []const u8,

    pub const json_field_names = .{
        .delete_catalog_only = "DeleteCatalogOnly",
        .name = "Name",
    };
};

pub const DeleteDataCatalogOutput = struct {
    data_catalog: ?DataCatalog = null,

    pub const json_field_names = .{
        .data_catalog = "DataCatalog",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataCatalogInput, options: CallOptions) !DeleteDataCatalogOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDataCatalogInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.DeleteDataCatalog");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDataCatalogOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteDataCatalogOutput, body, allocator);
}
