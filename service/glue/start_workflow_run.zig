const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartWorkflowRunInput = struct {
    /// The name of the workflow to start.
    name: []const u8,

    /// The workflow run properties for the new workflow run.
    ///
    /// Run properties may be logged. Do not pass plaintext secrets as properties.
    /// Retrieve secrets from a Glue Connection, Amazon Web Services Secrets Manager
    /// or other secret management mechanism if you intend to use them within the
    /// workflow run.
    run_properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .name = "Name",
        .run_properties = "RunProperties",
    };
};

pub const StartWorkflowRunOutput = struct {
    /// An Id for the new run.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .run_id = "RunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartWorkflowRunInput, options: CallOptions) !StartWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartWorkflowRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.StartWorkflowRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartWorkflowRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartWorkflowRunOutput, body, allocator);
}
