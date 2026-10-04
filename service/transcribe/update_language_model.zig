const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ModelStatus = @import("model_status.zig").ModelStatus;

pub const UpdateLanguageModelInput = struct {
    /// The Amazon Resource Name (ARN) of an IAM role. If you include
    /// `EncryptionConfiguration` in your request, this role must have permissions
    /// to
    /// access the specified KMS key. If the role that you specify doesn't have
    /// the appropriate permissions, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: ?[]const u8 = null,

    /// Specifies the new encryption configuration for your custom language model.
    /// The model artifacts are re-encrypted in place using the specified KMS key or
    /// with an AWS-owned key if a key is not supplied.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the custom language model you want to update. Model names are
    /// case sensitive.
    model_name: []const u8,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .encryption_configuration = "EncryptionConfiguration",
        .model_name = "ModelName",
    };
};

pub const UpdateLanguageModelOutput = struct {
    /// The date and time the specified custom language model was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the custom language model that was updated.
    model_name: ?[]const u8 = null,

    /// The status of the specified custom language model.
    model_status: ?ModelStatus = null,

    pub const json_field_names = .{
        .last_modified_time = "LastModifiedTime",
        .model_name = "ModelName",
        .model_status = "ModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLanguageModelInput, options: CallOptions) !UpdateLanguageModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLanguageModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.UpdateLanguageModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLanguageModelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateLanguageModelOutput, body, allocator);
}
