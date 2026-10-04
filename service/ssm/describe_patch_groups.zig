const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOrchestratorFilter = @import("patch_orchestrator_filter.zig").PatchOrchestratorFilter;
const PatchGroupPatchBaselineMapping = @import("patch_group_patch_baseline_mapping.zig").PatchGroupPatchBaselineMapping;

pub const DescribePatchGroupsInput = struct {
    /// Each element in the array is a structure containing a key-value pair.
    ///
    /// Supported keys for `DescribePatchGroups` include the following:
    ///
    /// * **
    /// `NAME_PREFIX`
    /// **
    ///
    /// Sample values: `AWS-` | `My-`.
    ///
    /// * **
    /// `OPERATING_SYSTEM`
    /// **
    ///
    /// Sample values: `AMAZON_LINUX` | `SUSE` | `WINDOWS`
    filters: ?[]const PatchOrchestratorFilter = null,

    /// The maximum number of patch groups to return (per page).
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribePatchGroupsOutput = struct {
    /// Each entry in the array contains:
    ///
    /// * `PatchGroup`: string (between 1 and 256 characters. Regex:
    /// `^([\p{L}\p{Z}\p{N}_.:/=+\-@]*)$)`
    ///
    /// * `PatchBaselineIdentity`: A `PatchBaselineIdentity` element.
    mappings: ?[]const PatchGroupPatchBaselineMapping = null,

    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .mappings = "Mappings",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePatchGroupsInput, options: CallOptions) !DescribePatchGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePatchGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribePatchGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePatchGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePatchGroupsOutput, body, allocator);
}
