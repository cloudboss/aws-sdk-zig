const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LcmOperationInfo = @import("lcm_operation_info.zig").LcmOperationInfo;
const GetSolNetworkInstanceMetadata = @import("get_sol_network_instance_metadata.zig").GetSolNetworkInstanceMetadata;
const NsState = @import("ns_state.zig").NsState;

pub const GetSolNetworkInstanceInput = struct {
    /// ID of the network instance.
    ns_instance_id: []const u8,

    pub const json_field_names = .{
        .ns_instance_id = "nsInstanceId",
    };
};

pub const GetSolNetworkInstanceOutput = struct {
    /// Network instance ARN.
    arn: []const u8,

    /// Network instance ID.
    id: []const u8,

    lcm_op_info: ?LcmOperationInfo = null,

    metadata: ?GetSolNetworkInstanceMetadata = null,

    /// Network service descriptor ID.
    nsd_id: []const u8,

    /// Network service descriptor info ID.
    nsd_info_id: []const u8,

    /// Network instance description.
    ns_instance_description: []const u8,

    /// Network instance name.
    ns_instance_name: []const u8,

    /// Network instance state.
    ns_state: ?NsState = null,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .lcm_op_info = "lcmOpInfo",
        .metadata = "metadata",
        .nsd_id = "nsdId",
        .nsd_info_id = "nsdInfoId",
        .ns_instance_description = "nsInstanceDescription",
        .ns_instance_name = "nsInstanceName",
        .ns_state = "nsState",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolNetworkInstanceInput, options: CallOptions) !GetSolNetworkInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolNetworkInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nslcm/v1/ns_instances/");
    try path_buf.appendSlice(allocator, input.ns_instance_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolNetworkInstanceOutput {
    const result: GetSolNetworkInstanceOutput = try aws.json.parseJsonObject(
        GetSolNetworkInstanceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
