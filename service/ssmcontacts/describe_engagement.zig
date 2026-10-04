const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeEngagementInput = struct {
    /// The Amazon Resource Name (ARN) of the engagement you want the details of.
    engagement_id: []const u8,

    pub const json_field_names = .{
        .engagement_id = "EngagementId",
    };
};

pub const DescribeEngagementOutput = struct {
    /// The ARN of the escalation plan or contacts involved in the engagement.
    contact_arn: []const u8,

    /// The secure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    content: []const u8,

    /// The ARN of the engagement.
    engagement_arn: []const u8,

    /// The ARN of the incident in which the engagement occurred.
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

    /// The time that the engagement started.
    start_time: ?i64 = null,

    /// The time that the engagement ended.
    stop_time: ?i64 = null,

    /// The secure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    subject: []const u8,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .content = "Content",
        .engagement_arn = "EngagementArn",
        .incident_id = "IncidentId",
        .public_content = "PublicContent",
        .public_subject = "PublicSubject",
        .sender = "Sender",
        .start_time = "StartTime",
        .stop_time = "StopTime",
        .subject = "Subject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEngagementInput, options: CallOptions) !DescribeEngagementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEngagementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.DescribeEngagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEngagementOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEngagementOutput, body, allocator);
}
