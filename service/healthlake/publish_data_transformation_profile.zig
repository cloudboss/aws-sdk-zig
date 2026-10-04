const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceFormat = @import("source_format.zig").SourceFormat;
const TargetFormat = @import("target_format.zig").TargetFormat;

pub const PublishDataTransformationProfileInput = struct {
    /// A description of what changed or why this version is being published.
    change_description: ?[]const u8 = null,

    /// The version number of a previously published version to republish as the new
    /// latest version. Use this parameter for rollback scenarios. If you omit this
    /// parameter, the service publishes the current DRAFT version.
    from_existing_version: ?i32 = null,

    /// The unique identifier of the profile to publish.
    profile_id: []const u8,

    /// The source data format of the profile.
    source_format: SourceFormat,

    pub const json_field_names = .{
        .change_description = "ChangeDescription",
        .from_existing_version = "FromExistingVersion",
        .profile_id = "ProfileId",
        .source_format = "SourceFormat",
    };
};

pub const PublishDataTransformationProfileOutput = struct {
    /// The timestamp when the profile was last updated.
    last_updated_at: i64,

    /// The unique identifier of the published profile.
    profile_id: []const u8,

    /// The name of the published profile.
    profile_name: ?[]const u8 = null,

    /// The source data format of the profile.
    source_format: SourceFormat,

    /// The target output format of the profile.
    target_format: TargetFormat,

    /// The new version number that was created.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishDataTransformationProfileInput, options: CallOptions) !PublishDataTransformationProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishDataTransformationProfileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.PublishDataTransformationProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishDataTransformationProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PublishDataTransformationProfileOutput, body, allocator);
}
