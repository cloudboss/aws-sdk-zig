const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AzureAccessTier = @import("azure_access_tier.zig").AzureAccessTier;
const AzureBlobAuthenticationType = @import("azure_blob_authentication_type.zig").AzureBlobAuthenticationType;
const AzureBlobType = @import("azure_blob_type.zig").AzureBlobType;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const AzureBlobSasConfiguration = @import("azure_blob_sas_configuration.zig").AzureBlobSasConfiguration;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationAzureBlobInput = struct {
    /// Specifies the access tier that you want your objects or files transferred
    /// into. This only
    /// applies when using the location as a transfer destination. For more
    /// information, see [Access
    /// tiers](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#azure-blob-access-tiers).
    access_tier: ?AzureAccessTier = null,

    /// (Optional) Specifies the Amazon Resource Name (ARN) of the DataSync agent
    /// that
    /// can connect with your Azure Blob Storage container. If you are setting up an
    /// agentless
    /// cross-cloud transfer, you do not need to specify a value for this parameter.
    ///
    /// You can specify more than one agent. For more information, see [Using
    /// multiple
    /// agents for your
    /// transfer](https://docs.aws.amazon.com/datasync/latest/userguide/multiple-agents.html).
    ///
    /// Make sure you configure this parameter correctly when you first create your
    /// storage
    /// location. You cannot add or remove agents from a storage location after you
    /// create
    /// it.
    agent_arns: ?[]const []const u8 = null,

    /// Specifies the authentication method DataSync uses to access your Azure Blob
    /// Storage. DataSync can access blob storage using a shared access signature
    /// (SAS).
    authentication_type: AzureBlobAuthenticationType,

    /// Specifies the type of blob that you want your objects or files to be when
    /// transferring
    /// them into Azure Blob Storage. Currently, DataSync only supports moving data
    /// into
    /// Azure Blob Storage as block blobs. For more information on blob types, see
    /// the [Azure Blob Storage
    /// documentation](https://learn.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs).
    blob_type: ?AzureBlobType = null,

    /// Specifies configuration information for a DataSync-managed secret, which
    /// includes the authentication token that DataSync uses to access a specific
    /// AzureBlob
    /// storage location, with a customer-managed KMS key.
    ///
    /// When you include this parameter as part of a `CreateLocationAzureBlob`
    /// request,
    /// you provide only the KMS key ARN. DataSync uses this KMS key together with
    /// the authentication token you specify for
    /// `SasConfiguration` to create a DataSync-managed secret to store the
    /// location access credentials.
    ///
    /// Make sure that DataSync has permission to access the KMS key that
    /// you specify.
    ///
    /// You can use either `CmkSecretConfig` (with `SasConfiguration`) or
    /// `CustomSecretConfig` (without `SasConfiguration`) to provide
    /// credentials for a `CreateLocationAzureBlob` request. Do not provide both
    /// parameters for the same request.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies the URL of the Azure Blob Storage container involved in your
    /// transfer.
    container_url: []const u8,

    /// Specifies configuration information for a customer-managed Secrets Manager
    /// secret where
    /// the authentication token for an AzureBlob storage location is stored in
    /// plain text, in Secrets
    /// Manager. This configuration includes the secret ARN, and the ARN for an IAM
    /// role
    /// that provides access to the secret.
    ///
    /// You can use either `CmkSecretConfig` (with `SasConfiguration`) or
    /// `CustomSecretConfig` (without `SasConfiguration`) to provide
    /// credentials for a `CreateLocationAzureBlob` request. Do not provide both
    /// parameters for the same request.
    custom_secret_config: ?CustomSecretConfig = null,

    /// Specifies the SAS configuration that allows DataSync to access your Azure
    /// Blob
    /// Storage.
    ///
    /// If you provide an authentication token using `SasConfiguration`, but do not
    /// provide secret configuration details using `CmkSecretConfig` or
    /// `CustomSecretConfig`, then DataSync stores the token using your
    /// Amazon Web Services account's secrets manager secret.
    sas_configuration: ?AzureBlobSasConfiguration = null,

    /// Specifies path segments if you want to limit your transfer to a virtual
    /// directory in your
    /// container (for example, `/my/images`).
    subdirectory: ?[]const u8 = null,

    /// Specifies labels that help you categorize, filter, and search for your
    /// Amazon Web Services
    /// resources. We recommend creating at least a name tag for your transfer
    /// location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .access_tier = "AccessTier",
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .blob_type = "BlobType",
        .cmk_secret_config = "CmkSecretConfig",
        .container_url = "ContainerUrl",
        .custom_secret_config = "CustomSecretConfig",
        .sas_configuration = "SasConfiguration",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationAzureBlobOutput = struct {
    /// The ARN of the Azure Blob Storage transfer location that you created.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationAzureBlobInput, options: CallOptions) !CreateLocationAzureBlobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationAzureBlobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationAzureBlob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationAzureBlobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationAzureBlobOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
