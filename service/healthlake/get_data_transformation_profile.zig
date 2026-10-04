const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceFormat = @import("source_format.zig").SourceFormat;
const TargetFormat = @import("target_format.zig").TargetFormat;

pub const GetDataTransformationProfileInput = struct {
    /// The unique identifier of the profile to retrieve.
    profile_id: []const u8,

    /// The version number to retrieve. Specify 0 to retrieve the DRAFT version. If
    /// you omit this parameter, the service returns the latest published version.
    profile_version: ?i32 = null,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
        .profile_version = "ProfileVersion",
    };
};

pub const GetDataTransformationProfileOutput = struct {
    /// A description of what changed in this version.
    change_description: ?[]const u8 = null,

    /// The timestamp when this version was last updated.
    last_updated_at: i64,

    /// The description of the profile.
    profile_description: ?[]const u8 = null,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    /// The profile content as a map of file paths to content strings.
    profile_mapping: ?[]const aws.map.StringMapEntry = null,

    /// The name of the profile.
    profile_name: ?[]const u8 = null,

    /// The source data format of the profile.
    source_format: SourceFormat,

    /// The target output format of the profile.
    target_format: TargetFormat,

    /// The version number of the retrieved profile.
    version: i32,

    pub const json_field_names = .{
        .change_description = "ChangeDescription",
        .last_updated_at = "LastUpdatedAt",
        .profile_description = "ProfileDescription",
        .profile_id = "ProfileId",
        .profile_mapping = "ProfileMapping",
        .profile_name = "ProfileName",
        .source_format = "SourceFormat",
        .target_format = "TargetFormat",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataTransformationProfileInput, options: CallOptions) !GetDataTransformationProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataTransformationProfileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.GetDataTransformationProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataTransformationProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDataTransformationProfileOutput, body, allocator);
}
