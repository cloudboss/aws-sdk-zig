const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingConfigurationListItem = @import("routing_configuration_list_item.zig").RoutingConfigurationListItem;

pub const CreateStateMachineAliasInput = struct {
    /// A description for the state machine alias.
    description: ?[]const u8 = null,

    /// The name of the state machine alias.
    ///
    /// To avoid conflict with version ARNs, don't use an integer in the name of the
    /// alias.
    name: []const u8,

    /// The routing configuration of a state machine alias. The routing
    /// configuration shifts
    /// execution traffic between two state machine versions. `routingConfiguration`
    /// contains an array of `RoutingConfig` objects that specify up to two state
    /// machine
    /// versions. Step Functions then randomly choses which version to run an
    /// execution with based
    /// on the weight assigned to each `RoutingConfig`.
    routing_configuration: []const RoutingConfigurationListItem,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .routing_configuration = "routingConfiguration",
    };
};

pub const CreateStateMachineAliasOutput = struct {
    /// The date the state machine alias was created.
    creation_date: i64,

    /// The Amazon Resource Name (ARN) that identifies the created state machine
    /// alias.
    state_machine_alias_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .state_machine_alias_arn = "stateMachineAliasArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStateMachineAliasInput, options: CallOptions) !CreateStateMachineAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStateMachineAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.CreateStateMachineAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStateMachineAliasOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateStateMachineAliasOutput, body, allocator);
}
