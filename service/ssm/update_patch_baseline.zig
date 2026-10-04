const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchRuleGroup = @import("patch_rule_group.zig").PatchRuleGroup;
const PatchComplianceLevel = @import("patch_compliance_level.zig").PatchComplianceLevel;
const PatchComplianceStatus = @import("patch_compliance_status.zig").PatchComplianceStatus;
const PatchFilterGroup = @import("patch_filter_group.zig").PatchFilterGroup;
const PatchAction = @import("patch_action.zig").PatchAction;
const PatchSource = @import("patch_source.zig").PatchSource;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;

pub const UpdatePatchBaselineInput = struct {
    /// A set of rules used to include patches in the baseline.
    approval_rules: ?PatchRuleGroup = null,

    /// A list of explicitly approved patches for the baseline.
    ///
    /// For information about accepted formats for lists of approved patches and
    /// rejected patches,
    /// see [Package
    /// name formats for approved and rejected patch
    /// lists](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html) in the *Amazon Web Services Systems Manager User Guide*.
    approved_patches: ?[]const []const u8 = null,

    /// Assigns a new compliance severity level to an existing patch baseline.
    approved_patches_compliance_level: ?PatchComplianceLevel = null,

    /// Indicates whether the list of approved patches includes non-security updates
    /// that should be
    /// applied to the managed nodes. The default value is `false`. Applies to Linux
    /// managed
    /// nodes only.
    approved_patches_enable_non_security: ?bool = null,

    /// Indicates the status to be assigned to security patches that are available
    /// but not approved
    /// because they don't meet the installation criteria specified in the patch
    /// baseline.
    ///
    /// Example scenario: Security patches that you might want installed can be
    /// skipped if you have
    /// specified a long period to wait after a patch is released before
    /// installation. If an update to
    /// the patch is released during your specified waiting period, the waiting
    /// period for installing the
    /// patch starts over. If the waiting period is too long, multiple versions of
    /// the patch could be
    /// released but never installed.
    ///
    /// Supported for Windows Server managed nodes only.
    available_security_updates_compliance_status: ?PatchComplianceStatus = null,

    /// The ID of the patch baseline to update.
    baseline_id: []const u8,

    /// A description of the patch baseline.
    description: ?[]const u8 = null,

    /// A set of global filters used to include patches in the baseline.
    ///
    /// The `GlobalFilters` parameter can be configured only by using the CLI or an
    /// Amazon Web Services SDK. It can't be configured from the Patch Manager
    /// console, and its value isn't displayed in the console.
    global_filters: ?PatchFilterGroup = null,

    /// The name of the patch baseline.
    name: ?[]const u8 = null,

    /// A list of explicitly rejected patches for the baseline.
    ///
    /// For information about accepted formats for lists of approved patches and
    /// rejected patches,
    /// see [Package
    /// name formats for approved and rejected patch
    /// lists](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html) in the *Amazon Web Services Systems Manager User Guide*.
    rejected_patches: ?[]const []const u8 = null,

    /// The action for Patch Manager to take on patches included in the
    /// `RejectedPackages` list.
    ///
    /// **ALLOW_AS_DEPENDENCY**
    ///
    /// **Linux and macOS**: A package in the rejected patches list
    /// is installed only if it is a dependency of another package. It is considered
    /// compliant with
    /// the patch baseline, and its status is reported as `INSTALLED_OTHER`. This is
    /// the
    /// default action if no option is specified.
    ///
    /// **Windows Server**: Windows Server doesn't support the
    /// concept of package dependencies. If a package in the rejected patches list
    /// and already
    /// installed on the node, its status is reported as `INSTALLED_OTHER`. Any
    /// package not
    /// already installed on the node is skipped. This is the default action if no
    /// option is
    /// specified.
    ///
    /// **BLOCK**
    ///
    /// **All OSs**: Packages in the rejected patches list, and
    /// packages that include them as dependencies, aren't installed by Patch
    /// Manager under any
    /// circumstances.
    ///
    /// State value assignment for patch compliance:
    ///
    /// * If a package was installed before it was added to the rejected patches
    ///   list, or is
    /// installed outside of Patch Manager afterward, it's considered noncompliant
    /// with the patch
    /// baseline and its status is reported as `INSTALLED_REJECTED`.
    ///
    /// * If an update attempts to install a dependency package that is now rejected
    ///   by the
    /// baseline, when previous versions of the package were not rejected, the
    /// package being updated
    /// is reported as `MISSING` for `SCAN` operations and as
    /// `FAILED` for `INSTALL` operations.
    rejected_patches_action: ?PatchAction = null,

    /// If True, then all fields that are required by the CreatePatchBaseline
    /// operation are also required for this API request. Optional fields that
    /// aren't specified are set
    /// to null.
    replace: ?bool = null,

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
        .description = "Description",
        .global_filters = "GlobalFilters",
        .name = "Name",
        .rejected_patches = "RejectedPatches",
        .rejected_patches_action = "RejectedPatchesAction",
        .replace = "Replace",
        .sources = "Sources",
    };
};

pub const UpdatePatchBaselineOutput = struct {
    /// A set of rules used to include patches in the baseline.
    approval_rules: ?PatchRuleGroup = null,

    /// A list of explicitly approved patches for the baseline.
    approved_patches: ?[]const []const u8 = null,

    /// The compliance severity level assigned to the patch baseline after the
    /// update
    /// completed.
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

    /// The ID of the deleted patch baseline.
    baseline_id: ?[]const u8 = null,

    /// The date when the patch baseline was created.
    created_date: ?i64 = null,

    /// A description of the patch baseline.
    description: ?[]const u8 = null,

    /// A set of global filters used to exclude patches from the baseline.
    global_filters: ?PatchFilterGroup = null,

    /// The date when the patch baseline was last modified.
    modified_date: ?i64 = null,

    /// The name of the patch baseline.
    name: ?[]const u8 = null,

    /// The operating system rule used by the updated patch baseline.
    operating_system: ?OperatingSystem = null,

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
        .rejected_patches = "RejectedPatches",
        .rejected_patches_action = "RejectedPatchesAction",
        .sources = "Sources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePatchBaselineInput, options: CallOptions) !UpdatePatchBaselineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePatchBaselineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdatePatchBaseline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePatchBaselineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePatchBaselineOutput, body, allocator);
}
