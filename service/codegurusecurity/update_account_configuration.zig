const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

pub const UpdateAccountConfigurationInput = struct {
    /// The customer-managed KMS key ARN you want to use for encryption. If not
    /// specified, CodeGuru Security will use an AWS-managed key for encryption. If
    /// you previously specified a customer-managed KMS key and want CodeGuru
    /// Security to use an AWS-managed key for encryption instead, pass nothing.
    encryption_config: EncryptionConfig,

    pub const json_field_names = .{
        .encryption_config = "encryptionConfig",
    };
};

pub const UpdateAccountConfigurationOutput = struct {
    /// An `EncryptionConfig` object that contains the KMS key ARN that is used for
    /// encryption. If you did not specify a customer-managed KMS key in the
    /// request, returns empty.
    encryption_config: ?EncryptionConfig = null,

    pub const json_field_names = .{
        .encryption_config = "encryptionConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountConfigurationInput, options: CallOptions) !UpdateAccountConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateAccountConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"encryptionConfig\":");
    try aws.json.writeValue(@TypeOf(input.encryption_config), input.encryption_config, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountConfigurationOutput {
    const result: UpdateAccountConfigurationOutput = try aws.json.parseJsonObject(
        UpdateAccountConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
