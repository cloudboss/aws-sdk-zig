const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RcsAgentFilter = @import("rcs_agent_filter.zig").RcsAgentFilter;
const Owner = @import("owner.zig").Owner;
const RcsAgentInformation = @import("rcs_agent_information.zig").RcsAgentInformation;

pub const DescribeRcsAgentsInput = struct {
    /// An array of RcsAgentFilter objects to filter the results.
    filters: ?[]const RcsAgentFilter = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// Use `SELF` to filter the list of RCS agents to ones your account owns or use
    /// `SHARED` to filter on RCS agents shared with your account. The `Owner` and
    /// `RcsAgentIds` parameters can't be used at the same time.
    owner: ?Owner = null,

    /// An array of unique identifiers for the RCS agents. This is an array of
    /// strings that can be either the RcsAgentId or RcsAgentArn.
    rcs_agent_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .owner = "Owner",
        .rcs_agent_ids = "RcsAgentIds",
    };
};

pub const DescribeRcsAgentsOutput = struct {
    /// The token to be used for the next set of paginated results. If this field is
    /// empty then there are no more results.
    next_token: ?[]const u8 = null,

    /// An array of RcsAgentInformation objects that contain the details for the
    /// requested RCS agents.
    rcs_agents: ?[]const RcsAgentInformation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rcs_agents = "RcsAgents",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRcsAgentsInput, options: CallOptions) !DescribeRcsAgentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRcsAgentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribeRcsAgents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRcsAgentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRcsAgentsOutput, body, allocator);
}
