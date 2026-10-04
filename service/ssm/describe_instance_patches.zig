const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOrchestratorFilter = @import("patch_orchestrator_filter.zig").PatchOrchestratorFilter;
const PatchComplianceData = @import("patch_compliance_data.zig").PatchComplianceData;

pub const DescribeInstancePatchesInput = struct {
    /// Each element in the array is a structure containing a key-value pair.
    ///
    /// Supported keys for `DescribeInstancePatches`include the following:
    ///
    /// * **
    /// `Classification`
    /// **
    ///
    /// Sample values: `Security` | `SecurityUpdates`
    ///
    /// * **
    /// `KBId`
    /// **
    ///
    /// Sample values: `KB4480056` | `java-1.7.0-openjdk.x86_64`
    ///
    /// * **
    /// `Severity`
    /// **
    ///
    /// Sample values: `Important` | `Medium` | `Low`
    ///
    /// * **
    /// `State`
    /// **
    ///
    /// Sample values: `Installed` | `InstalledOther` |
    /// `InstalledPendingReboot`
    ///
    /// For lists of all `State` values, see [Patch compliance
    /// state
    /// values](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-compliance-states.html) in the *Amazon Web Services Systems Manager User Guide*.
    filters: ?[]const PatchOrchestratorFilter = null,

    /// The ID of the managed node whose patch state information should be
    /// retrieved.
    instance_id: []const u8,

    /// The maximum number of patches to return (per page).
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeInstancePatchesOutput = struct {
    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    /// Each entry in the array is a structure containing:
    ///
    /// * Title (string)
    ///
    /// * KBId (string)
    ///
    /// * Classification (string)
    ///
    /// * Severity (string)
    ///
    /// * State (string, such as "INSTALLED" or "FAILED")
    ///
    /// * InstalledTime (DateTime)
    ///
    /// * InstalledBy (string)
    patches: ?[]const PatchComplianceData = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .patches = "Patches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstancePatchesInput, options: CallOptions) !DescribeInstancePatchesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstancePatchesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeInstancePatches");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstancePatchesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstancePatchesOutput, body, allocator);
}
