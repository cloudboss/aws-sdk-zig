const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribePageInput = struct {
    /// The ID of the engagement to a contact channel.
    page_id: []const u8,

    pub const json_field_names = .{
        .page_id = "PageId",
    };
};

pub const DescribePageOutput = struct {
    /// The ARN of the contact that was engaged.
    contact_arn: []const u8,

    /// The secure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    content: []const u8,

    /// The time that the contact channel received the engagement.
    delivery_time: ?i64 = null,

    /// The ARN of the engagement that engaged the contact channel.
    engagement_arn: []const u8,

    /// The ARN of the incident that engaged the contact channel.
    incident_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the engagement to a contact channel.
    page_arn: []const u8,

    /// The insecure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_content: ?[]const u8 = null,

    /// The insecure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_subject: ?[]const u8 = null,

    /// The time that the contact channel acknowledged the engagement.
    read_time: ?i64 = null,

    /// The user that started the engagement.
    sender: []const u8,

    /// The time the engagement was sent to the contact channel.
    sent_time: ?i64 = null,

    /// The secure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    subject: []const u8,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .content = "Content",
        .delivery_time = "DeliveryTime",
        .engagement_arn = "EngagementArn",
        .incident_id = "IncidentId",
        .page_arn = "PageArn",
        .public_content = "PublicContent",
        .public_subject = "PublicSubject",
        .read_time = "ReadTime",
        .sender = "Sender",
        .sent_time = "SentTime",
        .subject = "Subject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePageInput, options: CallOptions) !DescribePageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.DescribePage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribePageOutput, body, allocator);
}
