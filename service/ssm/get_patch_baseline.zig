const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchRuleGroup = @import("patch_rule_group.zig").PatchRuleGroup;
const PatchComplianceLevel = @import("patch_compliance_level.zig").PatchComplianceLevel;
const PatchComplianceStatus = @import("patch_compliance_status.zig").PatchComplianceStatus;
const PatchFilterGroup = @import("patch_filter_group.zig").PatchFilterGroup;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const PatchAction = @import("patch_action.zig").PatchAction;
const PatchSource = @import("patch_source.zig").PatchSource;

pub const GetPatchBaselineInput = struct {
    /// The ID of the patch baseline to retrieve.
    ///
    /// To retrieve information about an Amazon Web Services managed patch baseline,
    /// specify the full Amazon
    /// Resource Name (ARN) of the baseline. For example, for the baseline
    /// `AWS-AmazonLinuxDefaultPatchBaseline`, specify
    /// `arn:aws:ssm:us-east-2:733109147000:patchbaseline/pb-0e392de35e7c563b7`
    /// instead of
    /// `pb-0e392de35e7c563b7`.
    baseline_id: []const u8,

    pub const json_field_names = .{
        .baseline_id = "BaselineId",
    };
};

pub const GetPatchBaselineOutput = struct {
    /// A set of rules used to include patches in the baseline.
    approval_rules: ?PatchRuleGroup = null,

    /// A list of explicitly approved patches for the baseline.
    approved_patches: ?[]const []const u8 = null,

    /// Returns the specified compliance severity level for approved patches in the
    /// patch
    /// baseline.
    approved_patches_compliance_level: ?PatchComplianceLevel = null,

    /// Indicates whether the list of approved patches includes non-security updates
    /// that should be
    /// applied to the managed nodes. The default value is `false`. Applies to Linux
    /// managed
    /// nodes only.
    approved_patches_enable_non_security: ?bool = null,

    /// Indicates the compliance status of managed nodes for which security-related
    /// patches are
    /// available but were not approved. This preference is specified when the
    /// `CreatePatchBaseline` or `UpdatePatchBaseline` commands are run.
    ///
    /// Applies to Windows Server managed nodes only.
    available_security_updates_compliance_status: ?PatchComplianceStatus = null,

    /// The ID of the retrieved patch baseline.
    baseline_id: ?[]const u8 = null,

    /// The date the patch baseline was created.
    created_date: ?i64 = null,

    /// A description of the patch baseline.
    description: ?[]const u8 = null,

    /// A set of global filters used to exclude patches from the baseline.
    global_filters: ?PatchFilterGroup = null,

    /// The date the patch baseline was last modified.
    modified_date: ?i64 = null,

    /// The name of the patch baseline.
    name: ?[]const u8 = null,

    /// Returns the operating system specified for the patch baseline.
    operating_system: ?OperatingSystem = null,

    /// Patch groups included in the patch baseline.
    patch_groups: ?[]const []const u8 = null,

    /// A list of explicitly rejected patches for the baseline.
    rejected_patches: ?[]const []const u8 = null,

    /// The action specified to take on patches included in the `RejectedPatches`
    /// list. A
    /// patch can be allowed only if it is a dependency of another package, or
    /// blocked entirely along
    /// with packages that include it as a dependency.
    rejected_patches_action: ?PatchAction = null,

    /// Information about the patches to use to update the managed nodes, including
    /// target operating
    /// systems and source repositories. Applies to Linux managed nodes only.
    sources: ?[]const PatchSource = null,

    pub const json_field_names = .{
        .approval_rules = "ApprovalRules",
        .approved_patches = "ApprovedPatches",
        .approved_patches_compliance_level = "ApprovedPatchesComplianceLevel",
        .approved_patches_enable_non_security = "ApprovedPatchesEnableNonSecurity",
        .available_security_updates_compliance_status = "AvailableSecurityUpdatesComplianceStatus",
        .baseline_id = "BaselineId",
        .created_date = "CreatedDate",
        .description = "Description",
        .global_filters = "GlobalFilters",
        .modified_date = "ModifiedDate",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .patch_groups = "PatchGroups",
        .rejected_patches = "RejectedPatches",
        .rejected_patches_action = "RejectedPatchesAction",
        .sources = "Sources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPatchBaselineInput, options: CallOptions) !GetPatchBaselineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPatchBaselineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetPatchBaseline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPatchBaselineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPatchBaselineOutput, body, allocator);
}
