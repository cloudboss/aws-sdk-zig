const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetSolVnfInfo = @import("get_sol_vnf_info.zig").GetSolVnfInfo;
const VnfInstantiationState = @import("vnf_instantiation_state.zig").VnfInstantiationState;
const GetSolFunctionInstanceMetadata = @import("get_sol_function_instance_metadata.zig").GetSolFunctionInstanceMetadata;

pub const GetSolFunctionInstanceInput = struct {
    /// ID of the network function.
    vnf_instance_id: []const u8,

    pub const json_field_names = .{
        .vnf_instance_id = "vnfInstanceId",
    };
};

pub const GetSolFunctionInstanceOutput = struct {
    /// Network function instance ARN.
    arn: []const u8,

    /// Network function instance ID.
    id: []const u8,

    instantiated_vnf_info: ?GetSolVnfInfo = null,

    /// Network function instantiation state.
    instantiation_state: VnfInstantiationState,

    metadata: ?GetSolFunctionInstanceMetadata = null,

    /// Network instance ID.
    ns_instance_id: []const u8,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Function package descriptor ID.
    vnfd_id: []const u8,

    /// Function package descriptor version.
    vnfd_version: ?[]const u8 = null,

    /// Function package ID.
    vnf_pkg_id: []const u8,

    /// Network function product name.
    vnf_product_name: ?[]const u8 = null,

    /// Network function provider.
    vnf_provider: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .instantiated_vnf_info = "instantiatedVnfInfo",
        .instantiation_state = "instantiationState",
        .metadata = "metadata",
        .ns_instance_id = "nsInstanceId",
        .tags = "tags",
        .vnfd_id = "vnfdId",
        .vnfd_version = "vnfdVersion",
        .vnf_pkg_id = "vnfPkgId",
        .vnf_product_name = "vnfProductName",
        .vnf_provider = "vnfProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolFunctionInstanceInput, options: CallOptions) !GetSolFunctionInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolFunctionInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/vnflcm/v1/vnf_instances/");
    try path_buf.appendSlice(allocator, input.vnf_instance_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolFunctionInstanceOutput {
    var result: GetSolFunctionInstanceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSolFunctionInstanceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
