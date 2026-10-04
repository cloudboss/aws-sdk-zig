const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptAction = @import("accept_action.zig").AcceptAction;
const PolicyStatement = @import("policy_statement.zig").PolicyStatement;

pub const GetTrafficPolicyInput = struct {
    /// The identifier of the traffic policy resource.
    traffic_policy_id: []const u8,

    pub const json_field_names = .{
        .traffic_policy_id = "TrafficPolicyId",
    };
};

pub const GetTrafficPolicyOutput = struct {
    /// The timestamp of when the traffic policy was created.
    created_timestamp: ?i64 = null,

    /// The default action of the traffic policy.
    default_action: ?AcceptAction = null,

    /// The timestamp of when the traffic policy was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The maximum message size in bytes of email which is allowed in by this
    /// traffic policy—anything larger will be blocked.
    max_message_size_bytes: ?i32 = null,

    /// The list of conditions which are in the traffic policy resource.
    policy_statements: ?[]const PolicyStatement = null,

    /// The Amazon Resource Name (ARN) of the traffic policy resource.
    traffic_policy_arn: ?[]const u8 = null,

    /// The identifier of the traffic policy resource.
    traffic_policy_id: []const u8,

    /// A user-friendly name for the traffic policy resource.
    traffic_policy_name: []const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .default_action = "DefaultAction",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .max_message_size_bytes = "MaxMessageSizeBytes",
        .policy_statements = "PolicyStatements",
        .traffic_policy_arn = "TrafficPolicyArn",
        .traffic_policy_id = "TrafficPolicyId",
        .traffic_policy_name = "TrafficPolicyName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrafficPolicyInput, options: CallOptions) !GetTrafficPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrafficPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetTrafficPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrafficPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetTrafficPolicyOutput, body, allocator);
}
