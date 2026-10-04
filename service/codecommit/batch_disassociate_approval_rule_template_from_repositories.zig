const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDisassociateApprovalRuleTemplateFromRepositoriesError = @import("batch_disassociate_approval_rule_template_from_repositories_error.zig").BatchDisassociateApprovalRuleTemplateFromRepositoriesError;

pub const BatchDisassociateApprovalRuleTemplateFromRepositoriesInput = struct {
    /// The name of the template that you want to disassociate from one or more
    /// repositories.
    approval_rule_template_name: []const u8,

    /// The repository names that you want to disassociate from the approval rule
    /// template.
    ///
    /// The length constraint limit is for each string in the array. The array
    /// itself can be empty.
    repository_names: []const []const u8,

    pub const json_field_names = .{
        .approval_rule_template_name = "approvalRuleTemplateName",
        .repository_names = "repositoryNames",
    };
};

pub const BatchDisassociateApprovalRuleTemplateFromRepositoriesOutput = struct {
    /// A list of repository names that have had their association with the template
    /// removed.
    disassociated_repository_names: ?[]const []const u8 = null,

    /// A list of any errors that might have occurred while attempting to remove the
    /// association between the template and the repositories.
    errors: ?[]const BatchDisassociateApprovalRuleTemplateFromRepositoriesError = null,

    pub const json_field_names = .{
        .disassociated_repository_names = "disassociatedRepositoryNames",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateApprovalRuleTemplateFromRepositoriesInput, options: CallOptions) !BatchDisassociateApprovalRuleTemplateFromRepositoriesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateApprovalRuleTemplateFromRepositoriesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.BatchDisassociateApprovalRuleTemplateFromRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateApprovalRuleTemplateFromRepositoriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchDisassociateApprovalRuleTemplateFromRepositoriesOutput, body, allocator);
}
