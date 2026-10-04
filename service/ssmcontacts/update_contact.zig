const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Plan = @import("plan.zig").Plan;

pub const UpdateContactInput = struct {
    /// The Amazon Resource Name (ARN) of the contact or escalation plan you're
    /// updating.
    contact_id: []const u8,

    /// The full name of the contact or escalation plan.
    display_name: ?[]const u8 = null,

    /// A list of stages. A contact has an engagement plan with stages for specified
    /// contact
    /// channels. An escalation plan uses these stages to contact specified
    /// contacts.
    plan: ?Plan = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .display_name = "DisplayName",
        .plan = "Plan",
    };
};

pub const UpdateContactOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContactInput, options: CallOptions) !UpdateContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.UpdateContact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContactOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
