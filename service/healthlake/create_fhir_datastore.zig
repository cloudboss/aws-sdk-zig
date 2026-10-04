const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const BackupConfiguration = @import("backup_configuration.zig").BackupConfiguration;
const FHIRVersion = @import("fhir_version.zig").FHIRVersion;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const NlpConfiguration = @import("nlp_configuration.zig").NlpConfiguration;
const PreloadDataConfig = @import("preload_data_config.zig").PreloadDataConfig;
const ProfileConfiguration = @import("profile_configuration.zig").ProfileConfiguration;
const SseConfiguration = @import("sse_configuration.zig").SseConfiguration;
const Tag = @import("tag.zig").Tag;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

pub const CreateFHIRDatastoreInput = struct {
    /// The analytics configuration for the data store.
    analytics_configuration: ?AnalyticsConfiguration = null,

    /// The backup configuration for the data store.
    backup_configuration: ?BackupConfiguration = null,

    /// An optional user-provided token to ensure API idempotency.
    client_token: ?[]const u8 = null,

    /// The data store name (user-generated).
    datastore_name: ?[]const u8 = null,

    /// The FHIR release version supported by the data store. Current support is for
    /// version `R4`.
    datastore_type_version: FHIRVersion,

    /// The identity provider configuration to use for the data store.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// The natural language processing (NLP) configuration for the data store.
    nlp_configuration: ?NlpConfiguration = null,

    /// An optional parameter to preload (import) open source Synthea FHIR data upon
    /// creation of the data store.
    preload_data_config: ?PreloadDataConfig = null,

    /// The profile configuration for the data store.
    profile_configuration: ?ProfileConfiguration = null,

    /// The server-side encryption key configuration for a customer-provided
    /// encryption key specified for creating a data store.
    sse_configuration: ?SseConfiguration = null,

    /// The resource tags applied to a data store when it is created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .analytics_configuration = "AnalyticsConfiguration",
        .backup_configuration = "BackupConfiguration",
        .client_token = "ClientToken",
        .datastore_name = "DatastoreName",
        .datastore_type_version = "DatastoreTypeVersion",
        .identity_provider_configuration = "IdentityProviderConfiguration",
        .nlp_configuration = "NlpConfiguration",
        .preload_data_config = "PreloadDataConfig",
        .profile_configuration = "ProfileConfiguration",
        .sse_configuration = "SseConfiguration",
        .tags = "Tags",
    };
};

pub const CreateFHIRDatastoreOutput = struct {
    /// The Amazon Resource Name (ARN) for the data store.
    datastore_arn: []const u8,

    /// The Amazon Web Services endpoint created for the data store.
    datastore_endpoint: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    pub const json_field_names = .{
        .datastore_arn = "DatastoreArn",
        .datastore_endpoint = "DatastoreEndpoint",
        .datastore_id = "DatastoreId",
        .datastore_status = "DatastoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFHIRDatastoreInput, options: CallOptions) !CreateFHIRDatastoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.CreateFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFHIRDatastoreOutput, body, allocator);
}
