const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

pub const DeleteFHIRDatastoreInput = struct {
    /// The AWS-generated identifier for the data store to be deleted.
    datastore_id: []const u8,

    pub const json_field_names = .{
        .datastore_id = "DatastoreId",
    };
};

pub const DeleteFHIRDatastoreOutput = struct {
    /// The Amazon Resource Name (ARN) that grants access permission to AWS
    /// HealthLake.
    datastore_arn: []const u8,

    /// The AWS endpoint of the data store to be deleted.
    datastore_endpoint: []const u8,

    /// The AWS-generated ID for the deleted data store.
    datastore_id: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    pub const json_field_names = .{
        .datastore_arn = "DatastoreArn",
        .datastore_endpoint = "DatastoreEndpoint",
        .datastore_id = "DatastoreId",
        .datastore_status = "DatastoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFHIRDatastoreInput, options: CallOptions) !DeleteFHIRDatastoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.DeleteFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteFHIRDatastoreOutput, body, allocator);
}
