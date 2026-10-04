const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const MatchmakingRuleSet = @import("matchmaking_rule_set.zig").MatchmakingRuleSet;

pub const CreateMatchmakingRuleSetInput = struct {
    /// A unique identifier for the matchmaking rule set. A matchmaking
    /// configuration identifies the rule set it uses by this name
    /// value. Note that the rule set name is different from the optional `name`
    /// field in the rule set body.
    name: []const u8,

    /// A collection of matchmaking rules, formatted as a JSON string. Comments are
    /// not
    /// allowed in JSON, but most elements support a description field.
    rule_set_body: []const u8,

    /// A list of labels to assign to the new matchmaking rule set resource. Tags
    /// are
    /// developer-defined key-value pairs. Tagging Amazon Web Services resources are
    /// useful for resource
    /// management, access management and cost allocation. For more information, see
    /// [ Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .name = "Name",
        .rule_set_body = "RuleSetBody",
        .tags = "Tags",
    };
};

pub const CreateMatchmakingRuleSetOutput = struct {
    /// The newly created matchmaking rule set.
    rule_set: ?MatchmakingRuleSet = null,

    pub const json_field_names = .{
        .rule_set = "RuleSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMatchmakingRuleSetInput, options: CallOptions) !CreateMatchmakingRuleSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMatchmakingRuleSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateMatchmakingRuleSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMatchmakingRuleSetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateMatchmakingRuleSetOutput, body, allocator);
}
