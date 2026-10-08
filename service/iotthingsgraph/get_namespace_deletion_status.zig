const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NamespaceDeletionStatusErrorCodes = @import("namespace_deletion_status_error_codes.zig").NamespaceDeletionStatusErrorCodes;
const NamespaceDeletionStatus = @import("namespace_deletion_status.zig").NamespaceDeletionStatus;

pub const GetNamespaceDeletionStatusInput = struct {};

pub const GetNamespaceDeletionStatusOutput = struct {
    /// An error code returned by the namespace deletion task.
    error_code: ?NamespaceDeletionStatusErrorCodes = null,

    /// An error code returned by the namespace deletion task.
    error_message: ?[]const u8 = null,

    /// The ARN of the namespace that is being deleted.
    namespace_arn: ?[]const u8 = null,

    /// The name of the namespace that is being deleted.
    namespace_name: ?[]const u8 = null,

    /// The status of the deletion request.
    status: ?NamespaceDeletionStatus = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNamespaceDeletionStatusInput, options: CallOptions) !GetNamespaceDeletionStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNamespaceDeletionStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.GetNamespaceDeletionStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNamespaceDeletionStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetNamespaceDeletionStatusOutput, body, allocator);
}
