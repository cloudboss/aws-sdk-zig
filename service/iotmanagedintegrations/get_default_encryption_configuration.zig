const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

pub const GetDefaultEncryptionConfigurationInput = struct {};

pub const GetDefaultEncryptionConfigurationOutput = struct {
    /// Provides the status of the default encryption configuration for an Amazon
    /// Web Services account.
    configuration_status: ?ConfigurationStatus = null,

    /// The type of encryption used for the encryption configuration.
    encryption_type: EncryptionType,

    /// The Key Amazon Resource Name (ARN) of the AWS KMS key used for KMS
    /// encryption if you use `KMS_BASED_ENCRYPTION`.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_status = "configurationStatus",
        .encryption_type = "encryptionType",
        .kms_key_arn = "kmsKeyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDefaultEncryptionConfigurationInput, options: CallOptions) !GetDefaultEncryptionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDefaultEncryptionConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/account/encryption";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDefaultEncryptionConfigurationOutput {
    const result: GetDefaultEncryptionConfigurationOutput = try aws.json.parseJsonObject(
        GetDefaultEncryptionConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
