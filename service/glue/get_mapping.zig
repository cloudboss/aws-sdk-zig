const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Location = @import("location.zig").Location;
const CatalogEntry = @import("catalog_entry.zig").CatalogEntry;
const MappingEntry = @import("mapping_entry.zig").MappingEntry;

pub const GetMappingInput = struct {
    /// Parameters for the mapping.
    location: ?Location = null,

    /// A list of target tables.
    sinks: ?[]const CatalogEntry = null,

    /// Specifies the source table.
    source: CatalogEntry,

    pub const json_field_names = .{
        .location = "Location",
        .sinks = "Sinks",
        .source = "Source",
    };
};

pub const GetMappingOutput = struct {
    /// A list of mappings to the specified targets.
    mapping: ?[]const MappingEntry = null,

    pub const json_field_names = .{
        .mapping = "Mapping",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMappingInput, options: CallOptions) !GetMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMappingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetMapping");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMappingOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetMappingOutput, body, allocator);
}
