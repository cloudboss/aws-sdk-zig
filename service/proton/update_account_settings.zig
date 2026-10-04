const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryBranchInput = @import("repository_branch_input.zig").RepositoryBranchInput;
const AccountSettings = @import("account_settings.zig").AccountSettings;

pub const UpdateAccountSettingsInput = struct {
    /// Set to `true` to remove a configured pipeline repository from the account
    /// settings. Don't set this field if you are updating the
    /// configured pipeline repository.
    delete_pipeline_provisioning_repository: ?bool = null,

    /// The Amazon Resource Name (ARN) of the service role you want to use for
    /// provisioning pipelines. Proton assumes this role for CodeBuild-based
    /// provisioning.
    pipeline_codebuild_role_arn: ?[]const u8 = null,

    /// A linked repository for pipeline provisioning. Specify it if you have
    /// environments configured for self-managed provisioning with services that
    /// include pipelines. A linked repository is a repository that has been
    /// registered with Proton. For more information, see CreateRepository.
    ///
    /// To remove a previously configured repository, set
    /// `deletePipelineProvisioningRepository` to `true`, and don't set
    /// `pipelineProvisioningRepository`.
    pipeline_provisioning_repository: ?RepositoryBranchInput = null,

    /// The Amazon Resource Name (ARN) of the service role you want to use for
    /// provisioning pipelines. Assumed by Proton for Amazon Web Services-managed
    /// provisioning, and by customer-owned automation for self-managed
    /// provisioning.
    ///
    /// To remove a previously configured ARN, specify an empty string.
    pipeline_service_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_pipeline_provisioning_repository = "deletePipelineProvisioningRepository",
        .pipeline_codebuild_role_arn = "pipelineCodebuildRoleArn",
        .pipeline_provisioning_repository = "pipelineProvisioningRepository",
        .pipeline_service_role_arn = "pipelineServiceRoleArn",
    };
};

pub const UpdateAccountSettingsOutput = struct {
    /// The Proton pipeline service role and repository data shared across the
    /// Amazon Web Services account.
    account_settings: ?AccountSettings = null,

    pub const json_field_names = .{
        .account_settings = "accountSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, options: CallOptions) !UpdateAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateAccountSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountSettingsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAccountSettingsOutput, body, allocator);
}
