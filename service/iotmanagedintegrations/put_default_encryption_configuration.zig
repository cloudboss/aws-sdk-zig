const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

pub const PutDefaultEncryptionConfigurationInput = struct {
    /// The type of encryption used for the encryption configuration.
    encryption_type: EncryptionType,

    /// The Key Amazon Resource Name (ARN) of the AWS KMS key used for KMS
    /// encryption if you use `KMS_BASED_ENCRYPTION`.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_key_arn = "kmsKeyArn",
    };
};

pub const PutDefaultEncryptionConfigurationOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDefaultEncryptionConfigurationInput, options: CallOptions) !PutDefaultEncryptionConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDefaultEncryptionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/account/encryption";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"encryptionType\":");
    try aws.json.writeValue(@TypeOf(input.encryption_type), input.encryption_type, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDefaultEncryptionConfigurationOutput {
    var result: PutDefaultEncryptionConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutDefaultEncryptionConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
