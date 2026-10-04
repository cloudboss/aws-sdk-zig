const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRotationOverrideInput = struct {
    /// The Amazon Resource Name (ARN) of the overridden rotation to retrieve
    /// information
    /// about.
    rotation_id: []const u8,

    /// The Amazon Resource Name (ARN) of the on-call rotation override to retrieve
    /// information
    /// about.
    rotation_override_id: []const u8,

    pub const json_field_names = .{
        .rotation_id = "RotationId",
        .rotation_override_id = "RotationOverrideId",
    };
};

pub const GetRotationOverrideOutput = struct {
    /// The date and time when the override was created.
    create_time: ?i64 = null,

    /// The date and time when the override ends.
    end_time: ?i64 = null,

    /// The Amazon Resource Names (ARNs) of the contacts assigned to the override of
    /// the on-call
    /// rotation.
    new_contact_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the on-call rotation that was overridden.
    rotation_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the override to an on-call rotation.
    rotation_override_id: ?[]const u8 = null,

    /// The date and time when the override goes into effect.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .end_time = "EndTime",
        .new_contact_ids = "NewContactIds",
        .rotation_arn = "RotationArn",
        .rotation_override_id = "RotationOverrideId",
        .start_time = "StartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRotationOverrideInput, options: CallOptions) !GetRotationOverrideOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRotationOverrideInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-contacts", "SSM Contacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.GetRotationOverride");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRotationOverrideOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRotationOverrideOutput, body, allocator);
}
