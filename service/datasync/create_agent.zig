const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateAgentInput = struct {
    /// Specifies your DataSync agent's activation key. If you don't have an
    /// activation key, see [Activating your
    /// agent](https://docs.aws.amazon.com/datasync/latest/userguide/activate-agent.html).
    activation_key: []const u8,

    /// Specifies a name for your agent. We recommend specifying a name that you can
    /// remember.
    agent_name: ?[]const u8 = null,

    /// Specifies the Amazon Resource Name (ARN) of the security group that allows
    /// traffic between
    /// your agent and VPC service endpoint. You can only specify one ARN.
    security_group_arns: ?[]const []const u8 = null,

    /// Specifies the ARN of the subnet where your VPC service endpoint is located.
    /// You can only
    /// specify one ARN.
    subnet_arns: ?[]const []const u8 = null,

    /// Specifies labels that help you categorize, filter, and search for your
    /// Amazon Web Services resources. We recommend creating at least one tag for
    /// your agent.
    tags: ?[]const TagListEntry = null,

    /// Specifies the ID of the [VPC service
    /// endpoint](https://docs.aws.amazon.com/datasync/latest/userguide/choose-service-endpoint.html#datasync-in-vpc) that you're using. For example, a VPC endpoint ID looks like
    /// `vpce-01234d5aff67890e1`.
    ///
    /// The VPC service endpoint you use must include the DataSync service name (for
    /// example, `com.amazonaws.us-east-2.datasync`).
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .activation_key = "ActivationKey",
        .agent_name = "AgentName",
        .security_group_arns = "SecurityGroupArns",
        .subnet_arns = "SubnetArns",
        .tags = "Tags",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const CreateAgentOutput = struct {
    /// The ARN of the agent that you just activated. Use the
    /// [ListAgents](https://docs.aws.amazon.com/datasync/latest/userguide/API_ListAgents.html) operation to return a
    /// list of agents in your Amazon Web Services account and Amazon Web Services
    /// Region.
    agent_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_arn = "AgentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgentInput, options: CallOptions) !CreateAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datasync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateAgent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAgentOutput, body, allocator);
}
