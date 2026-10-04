const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameter = @import("parameter.zig").Parameter;

pub const GetParameterInput = struct {
    /// The name or Amazon Resource Name (ARN) of the parameter that you want to
    /// query. For
    /// parameters shared with you from another account, you must use the full ARN.
    ///
    /// To query by parameter label, use `"Name": "name:label"`. To query by
    /// parameter
    /// version, use `"Name": "name:version"`.
    ///
    /// For more information about shared parameters, see [Working with
    /// shared
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-shared-parameters.html) in the *Amazon Web Services Systems Manager User Guide*.
    name: []const u8,

    /// Return decrypted values for secure string parameters. This flag is ignored
    /// for
    /// `String` and `StringList` parameter types.
    with_decryption: ?bool = null,

    pub const json_field_names = .{
        .name = "Name",
        .with_decryption = "WithDecryption",
    };
};

pub const GetParameterOutput = struct {
    /// Information about a parameter.
    parameter: ?Parameter = null,

    pub const json_field_names = .{
        .parameter = "Parameter",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetParameterInput, options: CallOptions) !GetParameterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetParameterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetParameter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetParameterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetParameterOutput, body, allocator);
}
