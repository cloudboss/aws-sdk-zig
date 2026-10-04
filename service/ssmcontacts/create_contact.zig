const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Plan = @import("plan.zig").Plan;
const Tag = @import("tag.zig").Tag;
const ContactType = @import("contact_type.zig").ContactType;

pub const CreateContactInput = struct {
    /// The short name to quickly identify a contact or escalation plan. The contact
    /// alias must
    /// be unique and identifiable.
    alias: []const u8,

    /// The full name of the contact or escalation plan.
    display_name: ?[]const u8 = null,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// A list of stages. A contact has an engagement plan with stages that contact
    /// specified
    /// contact channels. An escalation plan uses stages that contact specified
    /// contacts.
    plan: Plan,

    /// Adds a tag to the target. You can only tag resources created in the first
    /// Region of your
    /// replication set.
    tags: ?[]const Tag = null,

    /// The type of contact to create.
    ///
    /// * `PERSONAL`: A single, individual contact.
    ///
    /// * `ESCALATION`: An escalation plan.
    ///
    /// * `ONCALL_SCHEDULE`: An on-call schedule.
    @"type": ContactType,

    pub const json_field_names = .{
        .alias = "Alias",
        .display_name = "DisplayName",
        .idempotency_token = "IdempotencyToken",
        .plan = "Plan",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreateContactOutput = struct {
    /// The Amazon Resource Name (ARN) of the created contact or escalation plan.
    contact_arn: []const u8,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactInput, options: CallOptions) !CreateContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.CreateContact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContactOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateContactOutput, body, allocator);
}
