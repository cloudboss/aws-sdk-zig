const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetSolNetworkPackageMetadata = @import("get_sol_network_package_metadata.zig").GetSolNetworkPackageMetadata;
const NsdOnboardingState = @import("nsd_onboarding_state.zig").NsdOnboardingState;
const NsdOperationalState = @import("nsd_operational_state.zig").NsdOperationalState;
const NsdUsageState = @import("nsd_usage_state.zig").NsdUsageState;

pub const GetSolNetworkPackageInput = struct {
    /// ID of the network service descriptor in the network package.
    nsd_info_id: []const u8,

    pub const json_field_names = .{
        .nsd_info_id = "nsdInfoId",
    };
};

pub const GetSolNetworkPackageOutput = struct {
    /// Network package ARN.
    arn: []const u8,

    /// Network package ID.
    id: []const u8,

    metadata: ?GetSolNetworkPackageMetadata = null,

    /// Network service descriptor ID.
    nsd_id: []const u8,

    /// Network service descriptor name.
    nsd_name: []const u8,

    /// Network service descriptor onboarding state.
    nsd_onboarding_state: NsdOnboardingState,

    /// Network service descriptor operational state.
    nsd_operational_state: NsdOperationalState,

    /// Network service descriptor usage state.
    nsd_usage_state: NsdUsageState,

    /// Network service descriptor version.
    nsd_version: []const u8,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Identifies the function package for the function package descriptor
    /// referenced by the
    /// onboarded network package.
    vnf_pkg_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .nsd_id = "nsdId",
        .nsd_name = "nsdName",
        .nsd_onboarding_state = "nsdOnboardingState",
        .nsd_operational_state = "nsdOperationalState",
        .nsd_usage_state = "nsdUsageState",
        .nsd_version = "nsdVersion",
        .tags = "tags",
        .vnf_pkg_ids = "vnfPkgIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolNetworkPackageInput, options: CallOptions) !GetSolNetworkPackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tnb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolNetworkPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nsd/v1/ns_descriptors/");
    try path_buf.appendSlice(allocator, input.nsd_info_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolNetworkPackageOutput {
    var result: GetSolNetworkPackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSolNetworkPackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
