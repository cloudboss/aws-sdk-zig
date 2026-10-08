const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutWorkflowRunPropertiesInput = struct {
    /// Name of the workflow which was run.
    name: []const u8,

    /// The ID of the workflow run for which the run properties should be updated.
    run_id: []const u8,

    /// The properties to put for the specified run.
    ///
    /// Run properties may be logged. Do not pass plaintext secrets as properties.
    /// Retrieve secrets from a Glue Connection, Amazon Web Services Secrets Manager
    /// or other secret management mechanism if you intend to use them within the
    /// workflow run.
    run_properties: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .name = "Name",
        .run_id = "RunId",
        .run_properties = "RunProperties",
    };
};

pub const PutWorkflowRunPropertiesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWorkflowRunPropertiesInput, options: CallOptions) !PutWorkflowRunPropertiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutWorkflowRunPropertiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutWorkflowRunProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutWorkflowRunPropertiesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
