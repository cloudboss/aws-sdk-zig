const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserImportJobType = @import("user_import_job_type.zig").UserImportJobType;

pub const StartUserImportJobInput = struct {
    /// The ID of a user import job that you previously created.
    job_id: []const u8,

    /// The ID of the user pool that you want to start importing users into.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
        .user_pool_id = "UserPoolId",
    };
};

pub const StartUserImportJobOutput = struct {
    /// The details of the user import job. Includes logging destination, status,
    /// and the Amazon S3
    /// pre-signed URL for CSV upload.
    user_import_job: ?UserImportJobType = null,

    pub const json_field_names = .{
        .user_import_job = "UserImportJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartUserImportJobInput, options: CallOptions) !StartUserImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartUserImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.StartUserImportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartUserImportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartUserImportJobOutput, body, allocator);
}
