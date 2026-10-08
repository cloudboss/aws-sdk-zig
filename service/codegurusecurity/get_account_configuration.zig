const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

pub const GetAccountConfigurationInput = struct {};

pub const GetAccountConfigurationOutput = struct {
    /// An `EncryptionConfig` object that contains the KMS key ARN that is used for
    /// encryption. By default, CodeGuru Security uses an AWS-managed key for
    /// encryption. To specify your own key, call `UpdateAccountConfiguration`. If
    /// you do not specify a customer-managed key, returns empty.
    encryption_config: ?EncryptionConfig = null,

    pub const json_field_names = .{
        .encryption_config = "encryptionConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountConfigurationInput, options: CallOptions) !GetAccountConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-security", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/accountConfiguration/get";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountConfigurationOutput {
    const result: GetAccountConfigurationOutput = try aws.json.parseJsonObject(
        GetAccountConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
