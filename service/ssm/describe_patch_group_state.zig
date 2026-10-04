const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribePatchGroupStateInput = struct {
    /// The name of the patch group whose patch snapshot should be retrieved.
    patch_group: []const u8,

    pub const json_field_names = .{
        .patch_group = "PatchGroup",
    };
};

pub const DescribePatchGroupStateOutput = struct {
    /// The number of managed nodes in the patch group.
    instances: ?i32 = null,

    /// The number of managed nodes for which security-related patches are available
    /// but not
    /// approved because because they didn't meet the patch baseline requirements.
    /// For example, an
    /// updated version of a patch might have been released before the specified
    /// auto-approval period was
    /// over.
    ///
    /// Applies to Windows Server managed nodes only.
    instances_with_available_security_updates: ?i32 = null,

    /// The number of managed nodes where patches that are specified as `Critical`
    /// for
    /// compliance reporting in the patch baseline aren't installed. These patches
    /// might be missing, have
    /// failed installation, were rejected, or were installed but awaiting a
    /// required managed node
    /// reboot. The status of these managed nodes is `NON_COMPLIANT`.
    instances_with_critical_non_compliant_patches: ?i32 = null,

    /// The number of managed nodes with patches from the patch baseline that failed
    /// to
    /// install.
    instances_with_failed_patches: ?i32 = null,

    /// The number of managed nodes with patches installed that aren't defined in
    /// the patch
    /// baseline.
    instances_with_installed_other_patches: ?i32 = null,

    /// The number of managed nodes with installed patches.
    instances_with_installed_patches: ?i32 = null,

    /// The number of managed nodes with patches installed by Patch Manager that
    /// haven't been
    /// rebooted after the patch installation. The status of these managed nodes is
    /// `NON_COMPLIANT`.
    instances_with_installed_pending_reboot_patches: ?i32 = null,

    /// The number of managed nodes with patches installed that are specified in a
    /// `RejectedPatches` list. Patches with a status of `INSTALLED_REJECTED` were
    /// typically installed before they were added to a `RejectedPatches` list.
    ///
    /// If `ALLOW_AS_DEPENDENCY` is the specified option for
    /// `RejectedPatchesAction`, the value of
    /// `InstancesWithInstalledRejectedPatches` will always be `0` (zero).
    instances_with_installed_rejected_patches: ?i32 = null,

    /// The number of managed nodes with missing patches from the patch baseline.
    instances_with_missing_patches: ?i32 = null,

    /// The number of managed nodes with patches that aren't applicable.
    instances_with_not_applicable_patches: ?i32 = null,

    /// The number of managed nodes with patches installed that are specified as
    /// other than
    /// `Critical` or `Security` but aren't compliant with the patch baseline. The
    /// status of these managed nodes is `NON_COMPLIANT`.
    instances_with_other_non_compliant_patches: ?i32 = null,

    /// The number of managed nodes where patches that are specified as `Security`
    /// in a
    /// patch advisory aren't installed. These patches might be missing, have failed
    /// installation, were
    /// rejected, or were installed but awaiting a required managed node reboot. The
    /// status of these
    /// managed nodes is `NON_COMPLIANT`.
    instances_with_security_non_compliant_patches: ?i32 = null,

    /// The number of managed nodes with `NotApplicable` patches beyond the
    /// supported
    /// limit, which aren't reported by name to Inventory. Inventory is a tool in
    /// Amazon Web Services Systems Manager.
    instances_with_unreported_not_applicable_patches: ?i32 = null,

    pub const json_field_names = .{
        .instances = "Instances",
        .instances_with_available_security_updates = "InstancesWithAvailableSecurityUpdates",
        .instances_with_critical_non_compliant_patches = "InstancesWithCriticalNonCompliantPatches",
        .instances_with_failed_patches = "InstancesWithFailedPatches",
        .instances_with_installed_other_patches = "InstancesWithInstalledOtherPatches",
        .instances_with_installed_patches = "InstancesWithInstalledPatches",
        .instances_with_installed_pending_reboot_patches = "InstancesWithInstalledPendingRebootPatches",
        .instances_with_installed_rejected_patches = "InstancesWithInstalledRejectedPatches",
        .instances_with_missing_patches = "InstancesWithMissingPatches",
        .instances_with_not_applicable_patches = "InstancesWithNotApplicablePatches",
        .instances_with_other_non_compliant_patches = "InstancesWithOtherNonCompliantPatches",
        .instances_with_security_non_compliant_patches = "InstancesWithSecurityNonCompliantPatches",
        .instances_with_unreported_not_applicable_patches = "InstancesWithUnreportedNotApplicablePatches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePatchGroupStateInput, options: CallOptions) !DescribePatchGroupStateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePatchGroupStateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribePatchGroupState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePatchGroupStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePatchGroupStateOutput, body, allocator);
}
