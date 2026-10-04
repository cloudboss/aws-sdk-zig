const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateDataTransformationProfileSource = @import("create_data_transformation_profile_source.zig").CreateDataTransformationProfileSource;
const SourceFormat = @import("source_format.zig").SourceFormat;
const TargetFormat = @import("target_format.zig").TargetFormat;

pub const CreateDataTransformationProfileInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// identifier used to encrypt the profile content at rest.
    kms_key_id: ?[]const u8 = null,

    /// A human-readable description of the profile's purpose.
    profile_description: ?[]const u8 = null,

    /// A name for the data transformation profile.
    profile_name: []const u8,

    /// The source for the initial profile content. Specify a built-in starter
    /// profile, an existing profile version to clone, raw profile content for CI/CD
    /// workflows, or a sample data file in Amazon S3.
    source: CreateDataTransformationProfileSource,

    /// The source data format that this profile converts from (Consolidated
    /// Clinical Document Architecture (C-CDA) or Comma-separated values (CSV)).
    source_format: SourceFormat,

    /// The tags to associate with the profile at creation time.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .kms_key_id = "KmsKeyId",
        .profile_description = "ProfileDescription",
        .profile_name = "ProfileName",
        .source = "Source",
        .source_format = "SourceFormat",
        .tags = "Tags",
    };
};

pub const CreateDataTransformationProfileOutput = struct {
    /// The timestamp when the profile was last updated.
    last_updated_at: i64,

    /// The unique identifier of the created profile.
    profile_id: []const u8,

    /// The name of the created profile.
    profile_name: []const u8,

    /// The source data format of the profile.
    source_format: SourceFormat,

    /// The target output format. Always `FHIR_R4`.
    target_format: TargetFormat,

    /// The version number of the newly created profile. The starting version is
    /// always 0, which indicates the profile is in DRAFT state.
    version: i32,

    pub const json_field_names = .{
        .last_updated_at = "LastUpdatedAt",
        .profile_id = "ProfileId",
        .profile_name = "ProfileName",
        .source_format = "SourceFormat",
        .target_format = "TargetFormat",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataTransformationProfileInput, options: CallOptions) !CreateDataTransformationProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataTransformationProfileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.CreateDataTransformationProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataTransformationProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateDataTransformationProfileOutput, body, allocator);
}
