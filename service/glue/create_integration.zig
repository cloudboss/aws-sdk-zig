const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationConfig = @import("integration_config.zig").IntegrationConfig;
const Tag = @import("tag.zig").Tag;
const IntegrationError = @import("integration_error.zig").IntegrationError;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const CreateIntegrationInput = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual information for encryption. This can only be provided if
    /// `KMSKeyId` is provided.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// Selects source tables for the integration using Maxwell filter syntax.
    data_filter: ?[]const u8 = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// The configuration settings.
    integration_config: ?IntegrationConfig = null,

    /// A unique name for an integration in Glue.
    integration_name: []const u8,

    /// The ARN of a KMS key used for encrypting the channel.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the source resource for the integration.
    source_arn: []const u8,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag = null,

    /// The ARN of the target resource for the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "AdditionalEncryptionContext",
        .data_filter = "DataFilter",
        .description = "Description",
        .integration_config = "IntegrationConfig",
        .integration_name = "IntegrationName",
        .kms_key_id = "KmsKeyId",
        .source_arn = "SourceArn",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub const CreateIntegrationOutput = struct {
    /// An optional set of non-secret key–value pairs that contains additional
    /// contextual information for encryption.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The time when the integration was created, in UTC.
    create_time: i64,

    /// Selects source tables for the integration using Maxwell filter syntax.
    data_filter: ?[]const u8 = null,

    /// A description of the integration.
    description: ?[]const u8 = null,

    /// A list of errors associated with the integration creation.
    errors: ?[]const IntegrationError = null,

    /// The Amazon Resource Name (ARN) for the created integration.
    integration_arn: []const u8,

    /// The configuration settings.
    integration_config: ?IntegrationConfig = null,

    /// A unique name for an integration in Glue.
    integration_name: []const u8,

    /// The ARN of a KMS key used for encrypting the channel.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the source resource for the integration.
    source_arn: []const u8,

    /// The status of the integration being created.
    ///
    /// The possible statuses are:
    ///
    /// * CREATING: The integration is being created.
    ///
    /// * ACTIVE: The integration creation succeeds.
    ///
    /// * MODIFYING: The integration is being modified.
    ///
    /// * FAILED: The integration creation fails.
    ///
    /// * DELETING: The integration is deleted.
    ///
    /// * SYNCING: The integration is synchronizing.
    ///
    /// * NEEDS_ATTENTION: The integration needs attention, such as synchronization.
    status: IntegrationStatus,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag = null,

    /// The ARN of the target resource for the integration.
    target_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "AdditionalEncryptionContext",
        .create_time = "CreateTime",
        .data_filter = "DataFilter",
        .description = "Description",
        .errors = "Errors",
        .integration_arn = "IntegrationArn",
        .integration_config = "IntegrationConfig",
        .integration_name = "IntegrationName",
        .kms_key_id = "KmsKeyId",
        .source_arn = "SourceArn",
        .status = "Status",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationInput, options: CallOptions) !CreateIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateIntegration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIntegrationOutput, body, allocator);
}
