const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateImageInput = struct {
    /// A list of properties to delete. Only the `Description` and `DisplayName`
    /// properties can be deleted.
    delete_properties: ?[]const []const u8 = null,

    /// The new description for the image.
    description: ?[]const u8 = null,

    /// The new display name for the image.
    display_name: ?[]const u8 = null,

    /// The name of the image to update.
    image_name: []const u8,

    /// The new ARN for the IAM role that enables Amazon SageMaker AI to perform
    /// tasks on your behalf.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_properties = "DeleteProperties",
        .description = "Description",
        .display_name = "DisplayName",
        .image_name = "ImageName",
        .role_arn = "RoleArn",
    };
};

pub const UpdateImageOutput = struct {
    /// The ARN of the image.
    image_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_arn = "ImageArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateImageInput, options: CallOptions) !UpdateImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateImageOutput, body, allocator);
}
