const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetSolFunctionPackageMetadata = @import("get_sol_function_package_metadata.zig").GetSolFunctionPackageMetadata;
const OnboardingState = @import("onboarding_state.zig").OnboardingState;
const OperationalState = @import("operational_state.zig").OperationalState;
const UsageState = @import("usage_state.zig").UsageState;

pub const GetSolFunctionPackageInput = struct {
    /// ID of the function package.
    vnf_pkg_id: []const u8,

    pub const json_field_names = .{
        .vnf_pkg_id = "vnfPkgId",
    };
};

pub const GetSolFunctionPackageOutput = struct {
    /// Function package ARN.
    arn: []const u8,

    /// Function package ID.
    id: []const u8,

    metadata: ?GetSolFunctionPackageMetadata = null,

    /// Function package onboarding state.
    onboarding_state: OnboardingState,

    /// Function package operational state.
    operational_state: OperationalState,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Function package usage state.
    usage_state: UsageState,

    /// Function package descriptor ID.
    vnfd_id: ?[]const u8 = null,

    /// Function package descriptor version.
    vnfd_version: ?[]const u8 = null,

    /// Network function product name.
    vnf_product_name: ?[]const u8 = null,

    /// Network function provider.
    vnf_provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .onboarding_state = "onboardingState",
        .operational_state = "operationalState",
        .tags = "tags",
        .usage_state = "usageState",
        .vnfd_id = "vnfdId",
        .vnfd_version = "vnfdVersion",
        .vnf_product_name = "vnfProductName",
        .vnf_provider = "vnfProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolFunctionPackageInput, options: CallOptions) !GetSolFunctionPackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolFunctionPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/vnfpkgm/v1/vnf_packages/");
    try path_buf.appendSlice(allocator, input.vnf_pkg_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolFunctionPackageOutput {
    var result: GetSolFunctionPackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSolFunctionPackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
