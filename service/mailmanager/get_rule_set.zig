const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Rule = @import("rule.zig").Rule;

pub const GetRuleSetInput = struct {
    /// The identifier of an existing rule set to be retrieved.
    rule_set_id: []const u8,

    pub const json_field_names = .{
        .rule_set_id = "RuleSetId",
    };
};

pub const GetRuleSetOutput = struct {
    /// The date of when then rule set was created.
    created_date: i64,

    /// The date of when the rule set was last modified.
    last_modification_date: i64,

    /// The rules contained in the rule set.
    rules: ?[]const Rule = null,

    /// The Amazon Resource Name (ARN) of the rule set resource.
    rule_set_arn: []const u8,

    /// The identifier of the rule set resource.
    rule_set_id: []const u8,

    /// A user-friendly name for the rule set resource.
    rule_set_name: []const u8,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .last_modification_date = "LastModificationDate",
        .rules = "Rules",
        .rule_set_arn = "RuleSetArn",
        .rule_set_id = "RuleSetId",
        .rule_set_name = "RuleSetName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRuleSetInput, options: CallOptions) !GetRuleSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRuleSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetRuleSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRuleSetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRuleSetOutput, body, allocator);
}
