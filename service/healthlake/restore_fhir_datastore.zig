const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const NlpConfiguration = @import("nlp_configuration.zig").NlpConfiguration;
const ProfileConfiguration = @import("profile_configuration.zig").ProfileConfiguration;
const RestoreConfiguration = @import("restore_configuration.zig").RestoreConfiguration;
const SseConfiguration = @import("sse_configuration.zig").SseConfiguration;
const Tag = @import("tag.zig").Tag;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

pub const RestoreFHIRDatastoreInput = struct {
    /// The analytics configuration for the restored data store.
    analytics_configuration: ?AnalyticsConfiguration = null,

    /// An optional user-provided token to ensure API idempotency of the restore.
    client_token: ?[]const u8 = null,

    /// The name for the restored data store.
    datastore_name: ?[]const u8 = null,

    /// The identity provider configuration for the restored data store.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// The NLP configuration for the restored data store.
    nlp_configuration: ?NlpConfiguration = null,

    /// The profile configuration for the restored data store.
    profile_configuration: ?ProfileConfiguration = null,

    /// The restore configuration specifying the type and parameters for the
    /// restore.
    restore_configuration: RestoreConfiguration,

    /// The identifier of the source data store to restore from.
    source_datastore_id: []const u8,

    /// The server-side encryption key configuration for the restored data store.
    sse_configuration: ?SseConfiguration = null,

    /// The resource tags applied to the restored data store.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .analytics_configuration = "AnalyticsConfiguration",
        .client_token = "ClientToken",
        .datastore_name = "DatastoreName",
        .identity_provider_configuration = "IdentityProviderConfiguration",
        .nlp_configuration = "NlpConfiguration",
        .profile_configuration = "ProfileConfiguration",
        .restore_configuration = "RestoreConfiguration",
        .source_datastore_id = "SourceDatastoreId",
        .sse_configuration = "SseConfiguration",
        .tags = "Tags",
    };
};

pub const RestoreFHIRDatastoreOutput = struct {
    /// The Amazon Resource Name (ARN) for the restored data store.
    datastore_arn: []const u8,

    /// The AWS endpoint for the restored data store.
    datastore_endpoint: []const u8,

    /// The restored data store identifier.
    datastore_id: []const u8,

    /// The restored data store status.
    datastore_status: DatastoreStatus,

    pub const json_field_names = .{
        .datastore_arn = "DatastoreArn",
        .datastore_endpoint = "DatastoreEndpoint",
        .datastore_id = "DatastoreId",
        .datastore_status = "DatastoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreFHIRDatastoreInput, options: CallOptions) !RestoreFHIRDatastoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.RestoreFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RestoreFHIRDatastoreOutput, body, allocator);
}
