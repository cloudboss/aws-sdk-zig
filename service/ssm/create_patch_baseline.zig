const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociatedInstances")) {
        const parsed_error: ?errors.AssociatedInstances = aws.json.parseJsonObject(errors.AssociatedInstances, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .associated_instances = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationAlreadyExists")) {
        const parsed_error: ?errors.AssociationAlreadyExists = aws.json.parseJsonObject(errors.AssociationAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationDoesNotExist")) {
        const parsed_error: ?errors.AssociationDoesNotExist = aws.json.parseJsonObject(errors.AssociationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationExecutionDoesNotExist")) {
        const parsed_error: ?errors.AssociationExecutionDoesNotExist = aws.json.parseJsonObject(errors.AssociationExecutionDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_execution_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationLimitExceeded")) {
        const parsed_error: ?errors.AssociationLimitExceeded = aws.json.parseJsonObject(errors.AssociationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AssociationVersionLimitExceeded")) {
        const parsed_error: ?errors.AssociationVersionLimitExceeded = aws.json.parseJsonObject(errors.AssociationVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .association_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotApprovedException")) {
        const parsed_error: ?errors.AutomationDefinitionNotApprovedException = aws.json.parseJsonObject(errors.AutomationDefinitionNotApprovedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_approved_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationDefinitionVersionNotFoundException")) {
        const parsed_error: ?errors.AutomationDefinitionVersionNotFoundException = aws.json.parseJsonObject(errors.AutomationDefinitionVersionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_definition_version_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionLimitExceededException")) {
        const parsed_error: ?errors.AutomationExecutionLimitExceededException = aws.json.parseJsonObject(errors.AutomationExecutionLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationExecutionNotFoundException")) {
        const parsed_error: ?errors.AutomationExecutionNotFoundException = aws.json.parseJsonObject(errors.AutomationExecutionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_execution_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AutomationStepNotFoundException")) {
        const parsed_error: ?errors.AutomationStepNotFoundException = aws.json.parseJsonObject(errors.AutomationStepNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .automation_step_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ComplianceTypeCountLimitExceededException")) {
        const parsed_error: ?errors.ComplianceTypeCountLimitExceededException = aws.json.parseJsonObject(errors.ComplianceTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .compliance_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomSchemaCountLimitExceededException")) {
        const parsed_error: ?errors.CustomSchemaCountLimitExceededException = aws.json.parseJsonObject(errors.CustomSchemaCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_schema_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentAlreadyExists")) {
        const parsed_error: ?errors.DocumentAlreadyExists = aws.json.parseJsonObject(errors.DocumentAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentLimitExceeded")) {
        const parsed_error: ?errors.DocumentLimitExceeded = aws.json.parseJsonObject(errors.DocumentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentPermissionLimit")) {
        const parsed_error: ?errors.DocumentPermissionLimit = aws.json.parseJsonObject(errors.DocumentPermissionLimit, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_permission_limit = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DocumentVersionLimitExceeded")) {
        const parsed_error: ?errors.DocumentVersionLimitExceeded = aws.json.parseJsonObject(errors.DocumentVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .document_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DoesNotExistException")) {
        const parsed_error: ?errors.DoesNotExistException = aws.json.parseJsonObject(errors.DoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentContent")) {
        const parsed_error: ?errors.DuplicateDocumentContent = aws.json.parseJsonObject(errors.DuplicateDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateDocumentVersionName")) {
        const parsed_error: ?errors.DuplicateDocumentVersionName = aws.json.parseJsonObject(errors.DuplicateDocumentVersionName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_document_version_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateInstanceId")) {
        const parsed_error: ?errors.DuplicateInstanceId = aws.json.parseJsonObject(errors.DuplicateInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FeatureNotAvailableException")) {
        const parsed_error: ?errors.FeatureNotAvailableException = aws.json.parseJsonObject(errors.FeatureNotAvailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .feature_not_available_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyLevelLimitExceededException")) {
        const parsed_error: ?errors.HierarchyLevelLimitExceededException = aws.json.parseJsonObject(errors.HierarchyLevelLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_level_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HierarchyTypeMismatchException")) {
        const parsed_error: ?errors.HierarchyTypeMismatchException = aws.json.parseJsonObject(errors.HierarchyTypeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .hierarchy_type_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        const parsed_error: ?errors.IdempotentParameterMismatch = aws.json.parseJsonObject(errors.IdempotentParameterMismatch, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatiblePolicyException")) {
        const parsed_error: ?errors.IncompatiblePolicyException = aws.json.parseJsonObject(errors.IncompatiblePolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivation")) {
        const parsed_error: ?errors.InvalidActivation = aws.json.parseJsonObject(errors.InvalidActivation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActivationId")) {
        const parsed_error: ?errors.InvalidActivationId = aws.json.parseJsonObject(errors.InvalidActivationId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_activation_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAggregatorException")) {
        const parsed_error: ?errors.InvalidAggregatorException = aws.json.parseJsonObject(errors.InvalidAggregatorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_aggregator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAllowedPatternException")) {
        const parsed_error: ?errors.InvalidAllowedPatternException = aws.json.parseJsonObject(errors.InvalidAllowedPatternException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_allowed_pattern_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociation")) {
        const parsed_error: ?errors.InvalidAssociation = aws.json.parseJsonObject(errors.InvalidAssociation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAssociationVersion")) {
        const parsed_error: ?errors.InvalidAssociationVersion = aws.json.parseJsonObject(errors.InvalidAssociationVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_association_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationExecutionParametersException")) {
        const parsed_error: ?errors.InvalidAutomationExecutionParametersException = aws.json.parseJsonObject(errors.InvalidAutomationExecutionParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_execution_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationSignalException")) {
        const parsed_error: ?errors.InvalidAutomationSignalException = aws.json.parseJsonObject(errors.InvalidAutomationSignalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_signal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAutomationStatusUpdateException")) {
        const parsed_error: ?errors.InvalidAutomationStatusUpdateException = aws.json.parseJsonObject(errors.InvalidAutomationStatusUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_automation_status_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommandId")) {
        const parsed_error: ?errors.InvalidCommandId = aws.json.parseJsonObject(errors.InvalidCommandId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_command_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeleteInventoryParametersException")) {
        const parsed_error: ?errors.InvalidDeleteInventoryParametersException = aws.json.parseJsonObject(errors.InvalidDeleteInventoryParametersException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_delete_inventory_parameters_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionIdException")) {
        const parsed_error: ?errors.InvalidDeletionIdException = aws.json.parseJsonObject(errors.InvalidDeletionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deletion_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocument")) {
        const parsed_error: ?errors.InvalidDocument = aws.json.parseJsonObject(errors.InvalidDocument, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentContent")) {
        const parsed_error: ?errors.InvalidDocumentContent = aws.json.parseJsonObject(errors.InvalidDocumentContent, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_content = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentOperation")) {
        const parsed_error: ?errors.InvalidDocumentOperation = aws.json.parseJsonObject(errors.InvalidDocumentOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_operation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentSchemaVersion")) {
        const parsed_error: ?errors.InvalidDocumentSchemaVersion = aws.json.parseJsonObject(errors.InvalidDocumentSchemaVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_schema_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentType")) {
        const parsed_error: ?errors.InvalidDocumentType = aws.json.parseJsonObject(errors.InvalidDocumentType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDocumentVersion")) {
        const parsed_error: ?errors.InvalidDocumentVersion = aws.json.parseJsonObject(errors.InvalidDocumentVersion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_document_version = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilter")) {
        const parsed_error: ?errors.InvalidFilter = aws.json.parseJsonObject(errors.InvalidFilter, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterKey")) {
        const parsed_error: ?errors.InvalidFilterKey = aws.json.parseJsonObject(errors.InvalidFilterKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterOption")) {
        const parsed_error: ?errors.InvalidFilterOption = aws.json.parseJsonObject(errors.InvalidFilterOption, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_option = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterValue")) {
        const parsed_error: ?errors.InvalidFilterValue = aws.json.parseJsonObject(errors.InvalidFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceId")) {
        const parsed_error: ?errors.InvalidInstanceId = aws.json.parseJsonObject(errors.InvalidInstanceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstanceInformationFilterValue")) {
        const parsed_error: ?errors.InvalidInstanceInformationFilterValue = aws.json.parseJsonObject(errors.InvalidInstanceInformationFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_information_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInstancePropertyFilterValue")) {
        const parsed_error: ?errors.InvalidInstancePropertyFilterValue = aws.json.parseJsonObject(errors.InvalidInstancePropertyFilterValue, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_instance_property_filter_value = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryGroupException")) {
        const parsed_error: ?errors.InvalidInventoryGroupException = aws.json.parseJsonObject(errors.InvalidInventoryGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryItemContextException")) {
        const parsed_error: ?errors.InvalidInventoryItemContextException = aws.json.parseJsonObject(errors.InvalidInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInventoryRequestException")) {
        const parsed_error: ?errors.InvalidInventoryRequestException = aws.json.parseJsonObject(errors.InvalidInventoryRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_inventory_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidItemContentException")) {
        const parsed_error: ?errors.InvalidItemContentException = aws.json.parseJsonObject(errors.InvalidItemContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_item_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyId")) {
        const parsed_error: ?errors.InvalidKeyId = aws.json.parseJsonObject(errors.InvalidKeyId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        const parsed_error: ?errors.InvalidNextToken = aws.json.parseJsonObject(errors.InvalidNextToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNotificationConfig")) {
        const parsed_error: ?errors.InvalidNotificationConfig = aws.json.parseJsonObject(errors.InvalidNotificationConfig, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_notification_config = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOptionException")) {
        const parsed_error: ?errors.InvalidOptionException = aws.json.parseJsonObject(errors.InvalidOptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_option_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputFolder")) {
        const parsed_error: ?errors.InvalidOutputFolder = aws.json.parseJsonObject(errors.InvalidOutputFolder, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_folder = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOutputLocation")) {
        const parsed_error: ?errors.InvalidOutputLocation = aws.json.parseJsonObject(errors.InvalidOutputLocation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_output_location = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameters")) {
        const parsed_error: ?errors.InvalidParameters = aws.json.parseJsonObject(errors.InvalidParameters, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameters = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPermissionType")) {
        const parsed_error: ?errors.InvalidPermissionType = aws.json.parseJsonObject(errors.InvalidPermissionType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_permission_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPluginName")) {
        const parsed_error: ?errors.InvalidPluginName = aws.json.parseJsonObject(errors.InvalidPluginName, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_plugin_name = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyAttributeException")) {
        const parsed_error: ?errors.InvalidPolicyAttributeException = aws.json.parseJsonObject(errors.InvalidPolicyAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyTypeException")) {
        const parsed_error: ?errors.InvalidPolicyTypeException = aws.json.parseJsonObject(errors.InvalidPolicyTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_policy_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceId")) {
        const parsed_error: ?errors.InvalidResourceId = aws.json.parseJsonObject(errors.InvalidResourceId, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_id = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceType")) {
        const parsed_error: ?errors.InvalidResourceType = aws.json.parseJsonObject(errors.InvalidResourceType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResultAttributeException")) {
        const parsed_error: ?errors.InvalidResultAttributeException = aws.json.parseJsonObject(errors.InvalidResultAttributeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_result_attribute_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRole")) {
        const parsed_error: ?errors.InvalidRole = aws.json.parseJsonObject(errors.InvalidRole, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSchedule")) {
        const parsed_error: ?errors.InvalidSchedule = aws.json.parseJsonObject(errors.InvalidSchedule, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_schedule = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTag")) {
        const parsed_error: ?errors.InvalidTag = aws.json.parseJsonObject(errors.InvalidTag, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTarget")) {
        const parsed_error: ?errors.InvalidTarget = aws.json.parseJsonObject(errors.InvalidTarget, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetMaps")) {
        const parsed_error: ?errors.InvalidTargetMaps = aws.json.parseJsonObject(errors.InvalidTargetMaps, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_maps = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeNameException")) {
        const parsed_error: ?errors.InvalidTypeNameException = aws.json.parseJsonObject(errors.InvalidTypeNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_type_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidUpdate")) {
        const parsed_error: ?errors.InvalidUpdate = aws.json.parseJsonObject(errors.InvalidUpdate, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_update = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvocationDoesNotExist")) {
        const parsed_error: ?errors.InvocationDoesNotExist = aws.json.parseJsonObject(errors.InvocationDoesNotExist, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invocation_does_not_exist = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemContentMismatchException")) {
        const parsed_error: ?errors.ItemContentMismatchException = aws.json.parseJsonObject(errors.ItemContentMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_content_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ItemSizeLimitExceededException")) {
        const parsed_error: ?errors.ItemSizeLimitExceededException = aws.json.parseJsonObject(errors.ItemSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .item_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedResourcePolicyDocumentException")) {
        const parsed_error: ?errors.MalformedResourcePolicyDocumentException = aws.json.parseJsonObject(errors.MalformedResourcePolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_resource_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxDocumentSizeExceeded")) {
        const parsed_error: ?errors.MaxDocumentSizeExceeded = aws.json.parseJsonObject(errors.MaxDocumentSizeExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_document_size_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoLongerSupportedException")) {
        const parsed_error: ?errors.NoLongerSupportedException = aws.json.parseJsonObject(errors.NoLongerSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_longer_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAccessDeniedException")) {
        const parsed_error: ?errors.OpsItemAccessDeniedException = aws.json.parseJsonObject(errors.OpsItemAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemConflictException")) {
        const parsed_error: ?errors.OpsItemConflictException = aws.json.parseJsonObject(errors.OpsItemConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemInvalidParameterException")) {
        const parsed_error: ?errors.OpsItemInvalidParameterException = aws.json.parseJsonObject(errors.OpsItemInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemLimitExceededException")) {
        const parsed_error: ?errors.OpsItemLimitExceededException = aws.json.parseJsonObject(errors.OpsItemLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemNotFoundException")) {
        const parsed_error: ?errors.OpsItemNotFoundException = aws.json.parseJsonObject(errors.OpsItemNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAlreadyExistsException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAlreadyExistsException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsItemRelatedItemAssociationNotFoundException")) {
        const parsed_error: ?errors.OpsItemRelatedItemAssociationNotFoundException = aws.json.parseJsonObject(errors.OpsItemRelatedItemAssociationNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_item_related_item_association_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataAlreadyExistsException")) {
        const parsed_error: ?errors.OpsMetadataAlreadyExistsException = aws.json.parseJsonObject(errors.OpsMetadataAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataInvalidArgumentException")) {
        const parsed_error: ?errors.OpsMetadataInvalidArgumentException = aws.json.parseJsonObject(errors.OpsMetadataInvalidArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_invalid_argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataKeyLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataKeyLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataKeyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_key_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataLimitExceededException")) {
        const parsed_error: ?errors.OpsMetadataLimitExceededException = aws.json.parseJsonObject(errors.OpsMetadataLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataNotFoundException")) {
        const parsed_error: ?errors.OpsMetadataNotFoundException = aws.json.parseJsonObject(errors.OpsMetadataNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OpsMetadataTooManyUpdatesException")) {
        const parsed_error: ?errors.OpsMetadataTooManyUpdatesException = aws.json.parseJsonObject(errors.OpsMetadataTooManyUpdatesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ops_metadata_too_many_updates_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterAlreadyExists")) {
        const parsed_error: ?errors.ParameterAlreadyExists = aws.json.parseJsonObject(errors.ParameterAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterLimitExceeded")) {
        const parsed_error: ?errors.ParameterLimitExceeded = aws.json.parseJsonObject(errors.ParameterLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterMaxVersionLimitExceeded")) {
        const parsed_error: ?errors.ParameterMaxVersionLimitExceeded = aws.json.parseJsonObject(errors.ParameterMaxVersionLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_max_version_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterNotFound")) {
        const parsed_error: ?errors.ParameterNotFound = aws.json.parseJsonObject(errors.ParameterNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterPatternMismatchException")) {
        const parsed_error: ?errors.ParameterPatternMismatchException = aws.json.parseJsonObject(errors.ParameterPatternMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_pattern_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionLabelLimitExceeded")) {
        const parsed_error: ?errors.ParameterVersionLabelLimitExceeded = aws.json.parseJsonObject(errors.ParameterVersionLabelLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_label_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterVersionNotFound")) {
        const parsed_error: ?errors.ParameterVersionNotFound = aws.json.parseJsonObject(errors.ParameterVersionNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_version_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PoliciesLimitExceededException")) {
        const parsed_error: ?errors.PoliciesLimitExceededException = aws.json.parseJsonObject(errors.PoliciesLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policies_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncAlreadyExistsException")) {
        const parsed_error: ?errors.ResourceDataSyncAlreadyExistsException = aws.json.parseJsonObject(errors.ResourceDataSyncAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncConflictException")) {
        const parsed_error: ?errors.ResourceDataSyncConflictException = aws.json.parseJsonObject(errors.ResourceDataSyncConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncCountExceededException")) {
        const parsed_error: ?errors.ResourceDataSyncCountExceededException = aws.json.parseJsonObject(errors.ResourceDataSyncCountExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_count_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncInvalidConfigurationException")) {
        const parsed_error: ?errors.ResourceDataSyncInvalidConfigurationException = aws.json.parseJsonObject(errors.ResourceDataSyncInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDataSyncNotFoundException")) {
        const parsed_error: ?errors.ResourceDataSyncNotFoundException = aws.json.parseJsonObject(errors.ResourceDataSyncNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_data_sync_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        const parsed_error: ?errors.ResourceLimitExceededException = aws.json.parseJsonObject(errors.ResourceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyConflictException")) {
        const parsed_error: ?errors.ResourcePolicyConflictException = aws.json.parseJsonObject(errors.ResourcePolicyConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyInvalidParameterException")) {
        const parsed_error: ?errors.ResourcePolicyInvalidParameterException = aws.json.parseJsonObject(errors.ResourcePolicyInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyLimitExceededException")) {
        const parsed_error: ?errors.ResourcePolicyLimitExceededException = aws.json.parseJsonObject(errors.ResourcePolicyLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        const parsed_error: ?errors.ResourcePolicyNotFoundException = aws.json.parseJsonObject(errors.ResourcePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceSettingNotFound")) {
        const parsed_error: ?errors.ServiceSettingNotFound = aws.json.parseJsonObject(errors.ServiceSettingNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_setting_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StatusUnchanged")) {
        const parsed_error: ?errors.StatusUnchanged = aws.json.parseJsonObject(errors.StatusUnchanged, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .status_unchanged = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubTypeCountLimitExceededException")) {
        const parsed_error: ?errors.SubTypeCountLimitExceededException = aws.json.parseJsonObject(errors.SubTypeCountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .sub_type_count_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetInUseException")) {
        const parsed_error: ?errors.TargetInUseException = aws.json.parseJsonObject(errors.TargetInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnected")) {
        const parsed_error: ?errors.TargetNotConnected = aws.json.parseJsonObject(errors.TargetNotConnected, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_connected = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsError")) {
        const parsed_error: ?errors.TooManyTagsError = aws.json.parseJsonObject(errors.TooManyTagsError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyUpdates")) {
        const parsed_error: ?errors.TooManyUpdates = aws.json.parseJsonObject(errors.TooManyUpdates, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_updates = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TotalSizeLimitExceededException")) {
        const parsed_error: ?errors.TotalSizeLimitExceededException = aws.json.parseJsonObject(errors.TotalSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .total_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedCalendarException")) {
        const parsed_error: ?errors.UnsupportedCalendarException = aws.json.parseJsonObject(errors.UnsupportedCalendarException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_calendar_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureRequiredException")) {
        const parsed_error: ?errors.UnsupportedFeatureRequiredException = aws.json.parseJsonObject(errors.UnsupportedFeatureRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_feature_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventoryItemContextException")) {
        const parsed_error: ?errors.UnsupportedInventoryItemContextException = aws.json.parseJsonObject(errors.UnsupportedInventoryItemContextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_item_context_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedInventorySchemaVersionException")) {
        const parsed_error: ?errors.UnsupportedInventorySchemaVersionException = aws.json.parseJsonObject(errors.UnsupportedInventorySchemaVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_inventory_schema_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperatingSystem")) {
        const parsed_error: ?errors.UnsupportedOperatingSystem = aws.json.parseJsonObject(errors.UnsupportedOperatingSystem, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operating_system = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedParameterType")) {
        const parsed_error: ?errors.UnsupportedParameterType = aws.json.parseJsonObject(errors.UnsupportedParameterType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_parameter_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlatformType")) {
        const parsed_error: ?errors.UnsupportedPlatformType = aws.json.parseJsonObject(errors.UnsupportedPlatformType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_platform_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
