const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Upload = @import("upload.zig").Upload;

pub const UpdateUploadInput = struct {
    /// The Amazon Resource Name (ARN) of the uploaded test spec.
    arn: []const u8,

    /// The upload's content type (for example, `application/x-yaml`).
    content_type: ?[]const u8 = null,

    /// Set to true if the YAML file has changed and must be updated. Otherwise, set
    /// to false.
    edit_content: ?bool = null,

    /// The upload's test spec file name. The name must not contain any forward
    /// slashes (/). The test spec file
    /// name must end with the `.yaml` or `.yml` file extension.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .content_type = "contentType",
        .edit_content = "editContent",
        .name = "name",
    };
};

pub const UpdateUploadOutput = struct {
    /// A test spec uploaded to Device Farm.
    upload: ?Upload = null,

    pub const json_field_names = .{
        .upload = "upload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUploadInput, options: CallOptions) !UpdateUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.UpdateUpload");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUploadOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateUploadOutput, body, allocator);
}
