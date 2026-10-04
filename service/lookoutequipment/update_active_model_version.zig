const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateActiveModelVersionInput = struct {
    /// The name of the machine learning model for which the active model version is
    /// being
    /// set.
    model_name: []const u8,

    /// The version of the machine learning model for which the active model version
    /// is being
    /// set.
    model_version: i64,

    pub const json_field_names = .{
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};

pub const UpdateActiveModelVersionOutput = struct {
    /// The version that is currently active of the machine learning model for which
    /// the active
    /// model version was set.
    current_active_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the machine learning model version that is
    /// the current
    /// active model version.
    current_active_version_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the machine learning model for which the
    /// active model
    /// version was set.
    model_arn: ?[]const u8 = null,

    /// The name of the machine learning model for which the active model version
    /// was
    /// set.
    model_name: ?[]const u8 = null,

    /// The previous version that was active of the machine learning model for which
    /// the active
    /// model version was set.
    previous_active_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the machine learning model version that
    /// was the
    /// previous active model version.
    previous_active_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_active_version = "CurrentActiveVersion",
        .current_active_version_arn = "CurrentActiveVersionArn",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .previous_active_version = "PreviousActiveVersion",
        .previous_active_version_arn = "PreviousActiveVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateActiveModelVersionInput, options: CallOptions) !UpdateActiveModelVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateActiveModelVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.UpdateActiveModelVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateActiveModelVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateActiveModelVersionOutput, body, allocator);
}
