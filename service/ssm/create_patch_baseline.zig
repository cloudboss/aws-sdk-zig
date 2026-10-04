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
const Tag = @import("tag.zig").Tag;

pub const CreatePatchBaselineInput = struct {
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

    /// Defines the compliance level for approved patches. When an approved patch is
    /// reported as
    /// missing, this value describes the severity of the compliance violation. The
    /// default value is
    /// `UNSPECIFIED`.
    approved_patches_compliance_level: ?PatchComplianceLevel = null,

    /// Indicates whether the list of approved patches includes non-security updates
    /// that should be
    /// applied to the managed nodes. The default value is `false`. Applies to Linux
    /// managed
    /// nodes only.
    approved_patches_enable_non_security: ?bool = null,

    /// Indicates the status you want to assign to security patches that are
    /// available but not
    /// approved because they don't meet the installation criteria specified in the
    /// patch
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

    /// User-provided idempotency token.
    client_token: ?[]const u8 = null,

    /// A description of the patch baseline.
    description: ?[]const u8 = null,

    /// A set of global filters used to include patches in the baseline.
    ///
    /// The `GlobalFilters` parameter can be configured only by using the CLI or an
    /// Amazon Web Services SDK. It can't be configured from the Patch Manager
    /// console, and its value isn't displayed in the console.
    global_filters: ?PatchFilterGroup = null,

    /// The name of the patch baseline.
    name: []const u8,

    /// Defines the operating system the patch baseline applies to. The default
    /// value is
    /// `WINDOWS`.
    operating_system: ?OperatingSystem = null,

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

    /// Information about the patches to use to update the managed nodes, including
    /// target operating
    /// systems and source repositories. Applies to Linux managed nodes only.
    sources: ?[]const PatchSource = null,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource in
    /// different ways, such as by purpose, owner, or environment. For example, you
    /// might want to tag a
    /// patch baseline to identify the severity level of patches it specifies and
    /// the operating system
    /// family it applies to. In this case, you could specify the following
    /// key-value pairs:
    ///
    /// * `Key=PatchSeverity,Value=Critical`
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// To add tags to an existing patch baseline, use the AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .approval_rules = "ApprovalRules",
        .approved_patches = "ApprovedPatches",
        .approved_patches_compliance_level = "ApprovedPatchesComplianceLevel",
        .approved_patches_enable_non_security = "ApprovedPatchesEnableNonSecurity",
        .available_security_updates_compliance_status = "AvailableSecurityUpdatesComplianceStatus",
        .client_token = "ClientToken",
        .description = "Description",
        .global_filters = "GlobalFilters",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .rejected_patches = "RejectedPatches",
        .rejected_patches_action = "RejectedPatchesAction",
        .sources = "Sources",
        .tags = "Tags",
    };
};

pub const CreatePatchBaselineOutput = struct {
    /// The ID of the created patch baseline.
    baseline_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_id = "BaselineId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePatchBaselineInput, options: CallOptions) !CreatePatchBaselineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePatchBaselineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreatePatchBaseline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePatchBaselineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePatchBaselineOutput, body, allocator);
}
