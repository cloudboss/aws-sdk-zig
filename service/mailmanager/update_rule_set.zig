const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Rule = @import("rule.zig").Rule;

pub const UpdateRuleSetInput = struct {
    /// A new set of rules to replace the current rules of the rule set—these rules
    /// will override all the rules of the rule set.
    rules: ?[]const Rule = null,

    /// The identifier of a rule set you want to update.
    rule_set_id: []const u8,

    /// A user-friendly name for the rule set resource.
    rule_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .rules = "Rules",
        .rule_set_id = "RuleSetId",
        .rule_set_name = "RuleSetName",
    };
};

pub const UpdateRuleSetOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRuleSetInput, options: CallOptions) !UpdateRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRuleSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.UpdateRuleSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRuleSetOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
