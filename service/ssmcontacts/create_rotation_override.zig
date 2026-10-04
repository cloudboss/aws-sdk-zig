const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRotationOverrideInput = struct {
    /// The date and time when the override ends.
    end_time: i64,

    /// A token that ensures that the operation is called only once with the
    /// specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the contacts to replace those in the
    /// current on-call
    /// rotation with.
    ///
    /// If you want to include any current team members in the override shift, you
    /// must include
    /// their ARNs in the new contact ID list.
    new_contact_ids: []const []const u8,

    /// The Amazon Resource Name (ARN) of the rotation to create an override for.
    rotation_id: []const u8,

    /// The date and time when the override goes into effect.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .idempotency_token = "IdempotencyToken",
        .new_contact_ids = "NewContactIds",
        .rotation_id = "RotationId",
        .start_time = "StartTime",
    };
};

pub const CreateRotationOverrideOutput = struct {
    /// The Amazon Resource Name (ARN) of the created rotation override.
    rotation_override_id: []const u8,

    pub const json_field_names = .{
        .rotation_override_id = "RotationOverrideId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRotationOverrideInput, options: CallOptions) !CreateRotationOverrideOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRotationOverrideInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.CreateRotationOverride");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRotationOverrideOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRotationOverrideOutput, body, allocator);
}
