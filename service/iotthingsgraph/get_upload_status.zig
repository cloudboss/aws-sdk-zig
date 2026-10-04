const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadStatus = @import("upload_status.zig").UploadStatus;

pub const GetUploadStatusInput = struct {
    /// The ID of the upload. This value is returned by the
    /// `UploadEntityDefinitions` action.
    upload_id: []const u8,

    pub const json_field_names = .{
        .upload_id = "uploadId",
    };
};

pub const GetUploadStatusOutput = struct {
    /// The date at which the upload was created.
    created_date: i64,

    /// The reason for an upload failure.
    failure_reason: ?[]const []const u8 = null,

    /// The ARN of the upload.
    namespace_arn: ?[]const u8 = null,

    /// The name of the upload's namespace.
    namespace_name: ?[]const u8 = null,

    /// The version of the user's namespace. Defaults to the latest version of the
    /// user's namespace.
    namespace_version: ?i64 = null,

    /// The ID of the upload.
    upload_id: []const u8,

    /// The status of the upload. The initial status is `IN_PROGRESS`. The response
    /// show all validation failures if the upload fails.
    upload_status: UploadStatus,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .failure_reason = "failureReason",
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .namespace_version = "namespaceVersion",
        .upload_id = "uploadId",
        .upload_status = "uploadStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUploadStatusInput, options: CallOptions) !GetUploadStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUploadStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.GetUploadStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUploadStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetUploadStatusOutput, body, allocator);
}
