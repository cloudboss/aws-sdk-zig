const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Language = @import("language.zig").Language;
const Tag = @import("tag.zig").Tag;
const Rule = @import("rule.zig").Rule;

pub const CreateRuleInput = struct {
    /// The rule description.
    description: ?[]const u8 = null,

    /// The detector ID for the rule's parent detector.
    detector_id: []const u8,

    /// The rule expression.
    expression: []const u8,

    /// The language of the rule.
    language: Language,

    /// The outcome or outcomes returned when the rule expression matches.
    outcomes: []const []const u8,

    /// The rule ID.
    rule_id: []const u8,

    /// A collection of key and value pairs.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .detector_id = "detectorId",
        .expression = "expression",
        .language = "language",
        .outcomes = "outcomes",
        .rule_id = "ruleId",
        .tags = "tags",
    };
};

pub const CreateRuleOutput = struct {
    /// The created rule.
    rule: ?Rule = null,

    pub const json_field_names = .{
        .rule = "rule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: CallOptions) !CreateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.CreateRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRuleOutput, body, allocator);
}
