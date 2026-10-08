const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptAction = @import("accept_action.zig").AcceptAction;
const PolicyStatement = @import("policy_statement.zig").PolicyStatement;

pub const UpdateTrafficPolicyInput = struct {
    /// Default action instructs the traﬃc policy to either Allow or Deny (block)
    /// messages that fall outside of (or not addressed by) the conditions of your
    /// policy statements
    default_action: ?AcceptAction = null,

    /// The maximum message size in bytes of email which is allowed in by this
    /// traffic policy—anything larger will be blocked.
    max_message_size_bytes: ?i32 = null,

    /// The list of conditions to be updated for filtering email traffic.
    policy_statements: ?[]const PolicyStatement = null,

    /// The identifier of the traffic policy that you want to update.
    traffic_policy_id: []const u8,

    /// A user-friendly name for the traffic policy resource.
    traffic_policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .max_message_size_bytes = "MaxMessageSizeBytes",
        .policy_statements = "PolicyStatements",
        .traffic_policy_id = "TrafficPolicyId",
        .traffic_policy_name = "TrafficPolicyName",
    };
};

pub const UpdateTrafficPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrafficPolicyInput, options: CallOptions) !UpdateTrafficPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrafficPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.UpdateTrafficPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrafficPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
