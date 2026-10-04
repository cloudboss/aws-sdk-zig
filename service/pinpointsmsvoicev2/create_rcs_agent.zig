const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const RcsAgentStatus = @import("rcs_agent_status.zig").RcsAgentStatus;

pub const CreateRcsAgentInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the RCS agent can't be
    /// deleted. You can change this value using the UpdateRcsAgent action.
    deletion_protection_enabled: ?bool = null,

    /// The OptOutList to associate with the RCS agent. Valid values are either
    /// OptOutListName or OptOutListArn.
    opt_out_list_name: ?[]const u8 = null,

    /// An array of tags (key and value pairs) associated with the RCS agent.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .opt_out_list_name = "OptOutListName",
        .tags = "Tags",
    };
};

pub const CreateRcsAgentOutput = struct {
    /// The time when the RCS agent was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: ?bool = null,

    /// The name of the OptOutList associated with the RCS agent.
    opt_out_list_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the newly created RCS agent.
    rcs_agent_arn: []const u8,

    /// The unique identifier for the RCS agent.
    rcs_agent_id: []const u8,

    /// By default this is set to false. When set to true you're responsible for
    /// responding to HELP and STOP requests. You're also responsible for tracking
    /// and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The current status of the RCS agent.
    status: RcsAgentStatus,

    /// An array of tags (key and value pairs) associated with the RCS agent.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .opt_out_list_name = "OptOutListName",
        .rcs_agent_arn = "RcsAgentArn",
        .rcs_agent_id = "RcsAgentId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .tags = "Tags",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRcsAgentInput, options: CallOptions) !CreateRcsAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRcsAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateRcsAgent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRcsAgentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRcsAgentOutput, body, allocator);
}
