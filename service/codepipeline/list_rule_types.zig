const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleOwner = @import("rule_owner.zig").RuleOwner;
const RuleType = @import("rule_type.zig").RuleType;

pub const ListRuleTypesInput = struct {
    /// The rule Region to filter on.
    region_filter: ?[]const u8 = null,

    /// The rule owner to filter on.
    rule_owner_filter: ?RuleOwner = null,

    pub const json_field_names = .{
        .region_filter = "regionFilter",
        .rule_owner_filter = "ruleOwnerFilter",
    };
};

pub const ListRuleTypesOutput = struct {
    /// Lists the rules that are configured for the condition.
    rule_types: ?[]const RuleType = null,

    pub const json_field_names = .{
        .rule_types = "ruleTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRuleTypesInput, options: CallOptions) !ListRuleTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRuleTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListRuleTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRuleTypesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRuleTypesOutput, body, allocator);
}
