const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Location = @import("s3_location.zig").S3Location;
const AwsCredentials = @import("aws_credentials.zig").AwsCredentials;

pub const RequestUploadCredentialsInput = struct {
    /// A unique identifier for the build to get credentials for. You can use either
    /// the build ID or ARN value.
    build_id: []const u8,

    pub const json_field_names = .{
        .build_id = "BuildId",
    };
};

pub const RequestUploadCredentialsOutput = struct {
    /// Amazon S3 path and key, identifying where the game build files are
    /// stored.
    storage_location: ?S3Location = null,

    /// Amazon Web Services credentials required when uploading a game build to the
    /// storage location. These
    /// credentials have a limited lifespan and are valid only for the build they
    /// were issued
    /// for.
    upload_credentials: ?AwsCredentials = null,

    pub const json_field_names = .{
        .storage_location = "StorageLocation",
        .upload_credentials = "UploadCredentials",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestUploadCredentialsInput, options: CallOptions) !RequestUploadCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RequestUploadCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.RequestUploadCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RequestUploadCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RequestUploadCredentialsOutput, body, allocator);
}
