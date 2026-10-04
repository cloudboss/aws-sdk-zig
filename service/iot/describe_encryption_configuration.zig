const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationDetails = @import("configuration_details.zig").ConfigurationDetails;
const EncryptionType = @import("encryption_type.zig").EncryptionType;

pub const DescribeEncryptionConfigurationInput = struct {
};

pub const DescribeEncryptionConfigurationOutput = struct {
    /// The encryption configuration details that include the status information of
    /// the KMS key
    /// and the KMS access role.
    configuration_details: ?ConfigurationDetails = null,

    /// The type of the KMS key.
    encryption_type: ?EncryptionType = null,

    /// The Amazon Resource Name (ARN) of the IAM role assumed by Amazon Web
    /// Services IoT Core to call KMS on
    /// behalf of the customer.
    kms_access_role_arn: ?[]const u8 = null,

    /// The ARN of the customer managed KMS key.
    kms_key_arn: ?[]const u8 = null,

    /// The date when encryption configuration is last updated.
    last_modified_date: ?i64 = null,

    pub const json_field_names = .{
        .configuration_details = "configurationDetails",
        .encryption_type = "encryptionType",
        .kms_access_role_arn = "kmsAccessRoleArn",
        .kms_key_arn = "kmsKeyArn",
        .last_modified_date = "lastModifiedDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEncryptionConfigurationInput, options: CallOptions) !DescribeEncryptionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEncryptionConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/encryption-configuration";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEncryptionConfigurationOutput {
    const result: DescribeEncryptionConfigurationOutput = try aws.json.parseJsonObject(
        DescribeEncryptionConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
