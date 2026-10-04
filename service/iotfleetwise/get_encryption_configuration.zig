const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionStatus = @import("encryption_status.zig").EncryptionStatus;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

pub const GetEncryptionConfigurationInput = struct {
};

pub const GetEncryptionConfigurationOutput = struct {
    /// The time when encryption was configured in seconds since epoch (January 1,
    /// 1970 at
    /// midnight UTC time).
    creation_time: ?i64 = null,

    /// The encryption status.
    encryption_status: EncryptionStatus,

    /// The type of encryption. Set to `KMS_BASED_ENCRYPTION` to use a KMS key
    /// that you own and manage. Set to `FLEETWISE_DEFAULT_ENCRYPTION` to use an
    /// Amazon Web Services managed key that is owned by the Amazon Web Services IoT
    /// FleetWise service account.
    encryption_type: EncryptionType,

    /// The error message that describes why encryption settings couldn't be
    /// configured, if
    /// applicable.
    error_message: ?[]const u8 = null,

    /// The ID of the KMS key that is used for encryption.
    kms_key_id: ?[]const u8 = null,

    /// The time when encryption was last updated in seconds since epoch (January 1,
    /// 1970 at
    /// midnight UTC time).
    last_modification_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .encryption_status = "encryptionStatus",
        .encryption_type = "encryptionType",
        .error_message = "errorMessage",
        .kms_key_id = "kmsKeyId",
        .last_modification_time = "lastModificationTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEncryptionConfigurationInput, options: CallOptions) !GetEncryptionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEncryptionConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetEncryptionConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEncryptionConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetEncryptionConfigurationOutput, body, allocator);
}
