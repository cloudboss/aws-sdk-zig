const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const BackupConfiguration = @import("backup_configuration.zig").BackupConfiguration;
const IdentityProviderConfiguration = @import("identity_provider_configuration.zig").IdentityProviderConfiguration;
const NlpConfiguration = @import("nlp_configuration.zig").NlpConfiguration;
const ProfileConfiguration = @import("profile_configuration.zig").ProfileConfiguration;
const DatastoreProperties = @import("datastore_properties.zig").DatastoreProperties;

pub const UpdateFHIRDatastoreInput = struct {
    /// The analytics configuration for the data store.
    analytics_configuration: ?AnalyticsConfiguration = null,

    /// The backup configuration for the data store.
    backup_configuration: ?BackupConfiguration = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store name.
    datastore_name: ?[]const u8 = null,

    /// The identity provider configuration for the data store.
    identity_provider_configuration: ?IdentityProviderConfiguration = null,

    /// The natural language processing (NLP) configuration for the data store.
    nlp_configuration: ?NlpConfiguration = null,

    /// The profile configuration for the data store.
    profile_configuration: ?ProfileConfiguration = null,

    pub const json_field_names = .{
        .analytics_configuration = "AnalyticsConfiguration",
        .backup_configuration = "BackupConfiguration",
        .datastore_id = "DatastoreId",
        .datastore_name = "DatastoreName",
        .identity_provider_configuration = "IdentityProviderConfiguration",
        .nlp_configuration = "NlpConfiguration",
        .profile_configuration = "ProfileConfiguration",
    };
};

pub const UpdateFHIRDatastoreOutput = struct {
    /// The data store properties.
    datastore_properties: ?DatastoreProperties = null,

    pub const json_field_names = .{
        .datastore_properties = "DatastoreProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFHIRDatastoreInput, options: CallOptions) !UpdateFHIRDatastoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFHIRDatastoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.UpdateFHIRDatastore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFHIRDatastoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateFHIRDatastoreOutput, body, allocator);
}
