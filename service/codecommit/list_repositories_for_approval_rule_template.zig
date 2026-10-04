const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListRepositoriesForApprovalRuleTemplateInput = struct {
    /// The name of the approval rule template for which you want to list
    /// repositories that are associated with that template.
    approval_rule_template_name: []const u8,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_rule_template_name = "approvalRuleTemplateName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListRepositoriesForApprovalRuleTemplateOutput = struct {
    /// An enumeration token that allows the operation to batch the next results of
    /// the operation.
    next_token: ?[]const u8 = null,

    /// A list of repository names that are associated with the specified approval
    /// rule template.
    repository_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .repository_names = "repositoryNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRepositoriesForApprovalRuleTemplateInput, options: CallOptions) !ListRepositoriesForApprovalRuleTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRepositoriesForApprovalRuleTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.ListRepositoriesForApprovalRuleTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositoriesForApprovalRuleTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRepositoriesForApprovalRuleTemplateOutput, body, allocator);
}
