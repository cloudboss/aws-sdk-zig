const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteParametersInput = struct {
    /// The names of the parameters to delete. After deleting a parameter, wait for
    /// at least 30
    /// seconds to create a parameter with the same name.
    ///
    /// You can't enter the Amazon Resource Name (ARN) for a parameter, only the
    /// parameter name
    /// itself.
    names: []const []const u8,

    pub const json_field_names = .{
        .names = "Names",
    };
};

pub const DeleteParametersOutput = struct {
    /// The names of the deleted parameters.
    deleted_parameters: ?[]const []const u8 = null,

    /// The names of parameters that weren't deleted because the parameters aren't
    /// valid.
    invalid_parameters: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .deleted_parameters = "DeletedParameters",
        .invalid_parameters = "InvalidParameters",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteParametersInput, options: CallOptions) !DeleteParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeleteParameters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteParametersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteParametersOutput, body, allocator);
}
