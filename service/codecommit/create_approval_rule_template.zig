const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalRuleTemplate = @import("approval_rule_template.zig").ApprovalRuleTemplate;

pub const CreateApprovalRuleTemplateInput = struct {
    /// The content of the approval rule that is created on pull requests in
    /// associated
    /// repositories. If you specify one or more destination references (branches),
    /// approval
    /// rules are created in an associated repository only if their destination
    /// references
    /// (branches) match those specified in the template.
    ///
    /// When you create the content of the approval rule template, you can specify
    /// approvers in an approval pool in one of two ways:
    ///
    /// * **CodeCommitApprovers**: This option only
    /// requires an Amazon Web Services account and a resource. It can be used for
    /// both IAM users
    /// and federated access users whose name matches the provided resource name.
    /// This is a very powerful option that offers a great deal of flexibility. For
    /// example, if you specify the Amazon Web Services account *123456789012*
    /// and *Mary_Major*, all of the following are counted as
    /// approvals coming from that user:
    ///
    /// * An IAM user in the account
    /// (arn:aws:iam::*123456789012*:user/*Mary_Major*)
    ///
    /// * A federated user identified in IAM as Mary_Major
    /// (arn:aws:sts::*123456789012*:federated-user/*Mary_Major*)
    ///
    /// This option does not recognize an active session of someone assuming the
    /// role of CodeCommitReview with a role session name of
    /// *Mary_Major*
    /// (arn:aws:sts::*123456789012*:assumed-role/CodeCommitReview/*Mary_Major*)
    /// unless you include a wildcard (*Mary_Major).
    ///
    /// * **Fully qualified ARN**: This option allows
    /// you to specify the fully qualified Amazon Resource Name (ARN) of the IAM
    /// user or role.
    ///
    /// For more information about IAM ARNs, wildcards, and formats, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the *IAM User Guide*.
    approval_rule_template_content: []const u8,

    /// The description of the approval rule template. Consider providing a
    /// description that
    /// explains what this template does and when it might be appropriate to
    /// associate it with
    /// repositories.
    approval_rule_template_description: ?[]const u8 = null,

    /// The name of the approval rule template. Provide descriptive names, because
    /// this name
    /// is applied to the approval rules created automatically in associated
    /// repositories.
    approval_rule_template_name: []const u8,

    pub const json_field_names = .{
        .approval_rule_template_content = "approvalRuleTemplateContent",
        .approval_rule_template_description = "approvalRuleTemplateDescription",
        .approval_rule_template_name = "approvalRuleTemplateName",
    };
};

pub const CreateApprovalRuleTemplateOutput = struct {
    /// The content and structure of the created approval rule template.
    approval_rule_template: ?ApprovalRuleTemplate = null,

    pub const json_field_names = .{
        .approval_rule_template = "approvalRuleTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApprovalRuleTemplateInput, options: CallOptions) !CreateApprovalRuleTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApprovalRuleTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.CreateApprovalRuleTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApprovalRuleTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateApprovalRuleTemplateOutput, body, allocator);
}
