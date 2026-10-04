const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptAction = @import("accept_action.zig").AcceptAction;
const PolicyStatement = @import("policy_statement.zig").PolicyStatement;
const Tag = @import("tag.zig").Tag;

pub const CreateTrafficPolicyInput = struct {
    /// A unique token that Amazon SES uses to recognize subsequent retries of the
    /// same request.
    client_token: ?[]const u8 = null,

    /// Default action instructs the traﬃc policy to either Allow or Deny (block)
    /// messages that fall outside of (or not addressed by) the conditions of your
    /// policy statements
    default_action: AcceptAction,

    /// The maximum message size in bytes of email which is allowed in by this
    /// traffic policy—anything larger will be blocked.
    max_message_size_bytes: ?i32 = null,

    /// Conditional statements for filtering email traffic.
    policy_statements: []const PolicyStatement,

    /// The tags used to organize, track, or control access for the resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const Tag = null,

    /// A user-friendly name for the traffic policy resource.
    traffic_policy_name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .default_action = "DefaultAction",
        .max_message_size_bytes = "MaxMessageSizeBytes",
        .policy_statements = "PolicyStatements",
        .tags = "Tags",
        .traffic_policy_name = "TrafficPolicyName",
    };
};

pub const CreateTrafficPolicyOutput = struct {
    /// The identifier of the traffic policy resource.
    traffic_policy_id: []const u8,

    pub const json_field_names = .{
        .traffic_policy_id = "TrafficPolicyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrafficPolicyInput, options: CallOptions) !CreateTrafficPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrafficPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.CreateTrafficPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrafficPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTrafficPolicyOutput, body, allocator);
}
