const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatastoreProperties = @import("datastore_properties.zig").DatastoreProperties;

pub const DescribeFHIRDatastoreInput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    pub const json_field_names = .{
        .datastore_id = "DatastoreId",
    };
};

pub const DescribeFHIRDatastoreOutput = struct {
    /// The data store properties.
    datastore_properties: ?DatastoreProperties = null,

    pub const json_field_names = .{
        .datastore_properties = "DatastoreProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFHIRDatastoreInput, options: CallOptions) !DescribeFHIRDatastoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.DescribeFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeFHIRDatastoreOutput, body, allocator);
}
