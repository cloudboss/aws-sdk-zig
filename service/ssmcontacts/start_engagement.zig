const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartEngagementInput = struct {
    /// The Amazon Resource Name (ARN) of the contact being engaged.
    contact_id: []const u8,

    /// The secure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` or `EMAIL`.
    content: []const u8,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// The ARN of the incident that the engagement is part of.
    incident_id: ?[]const u8 = null,

    /// The insecure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_content: ?[]const u8 = null,

    /// The insecure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_subject: ?[]const u8 = null,

    /// The user that started the engagement.
    sender: []const u8,

    /// The secure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` or `EMAIL`.
    subject: []const u8,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .content = "Content",
        .idempotency_token = "IdempotencyToken",
        .incident_id = "IncidentId",
        .public_content = "PublicContent",
        .public_subject = "PublicSubject",
        .sender = "Sender",
        .subject = "Subject",
    };
};

pub const StartEngagementOutput = struct {
    /// The ARN of the engagement.
    engagement_arn: []const u8,

    pub const json_field_names = .{
        .engagement_arn = "EngagementArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEngagementInput, options: CallOptions) !StartEngagementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEngagementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.StartEngagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEngagementOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartEngagementOutput, body, allocator);
}
