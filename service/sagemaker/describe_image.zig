const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageStatus = @import("image_status.zig").ImageStatus;

pub const DescribeImageInput = struct {
    /// The name of the image to describe.
    image_name: []const u8,

    pub const json_field_names = .{
        .image_name = "ImageName",
    };
};

pub const DescribeImageOutput = struct {
    /// When the image was created.
    creation_time: ?i64 = null,

    /// The description of the image.
    description: ?[]const u8 = null,

    /// The name of the image as displayed.
    display_name: ?[]const u8 = null,

    /// When a create, update, or delete operation fails, the reason for the
    /// failure.
    failure_reason: ?[]const u8 = null,

    /// The ARN of the image.
    image_arn: ?[]const u8 = null,

    /// The name of the image.
    image_name: ?[]const u8 = null,

    /// The status of the image.
    image_status: ?ImageStatus = null,

    /// When the image was last modified.
    last_modified_time: ?i64 = null,

    /// The ARN of the IAM role that enables Amazon SageMaker AI to perform tasks on
    /// your behalf.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .display_name = "DisplayName",
        .failure_reason = "FailureReason",
        .image_arn = "ImageArn",
        .image_name = "ImageName",
        .image_status = "ImageStatus",
        .last_modified_time = "LastModifiedTime",
        .role_arn = "RoleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImageInput, options: CallOptions) !DescribeImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImageOutput, body, allocator);
}
