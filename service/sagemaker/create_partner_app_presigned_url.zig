const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreatePartnerAppPresignedUrlInput = struct {
    /// The ARN of the SageMaker Partner AI App to create the presigned URL for.
    arn: []const u8,

    /// The time that will pass before the presigned URL expires.
    expires_in_seconds: ?i32 = null,

    /// Indicates how long the Amazon SageMaker Partner AI App session can be
    /// accessed for after logging in.
    session_expiration_duration_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .expires_in_seconds = "ExpiresInSeconds",
        .session_expiration_duration_in_seconds = "SessionExpirationDurationInSeconds",
    };
};

pub const CreatePartnerAppPresignedUrlOutput = struct {
    /// The presigned URL that you can use to access the SageMaker Partner AI App.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePartnerAppPresignedUrlInput, options: CallOptions) !CreatePartnerAppPresignedUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePartnerAppPresignedUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreatePartnerAppPresignedUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePartnerAppPresignedUrlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePartnerAppPresignedUrlOutput, body, allocator);
}
