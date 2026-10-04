const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProblemDetails = @import("problem_details.zig").ProblemDetails;
const LcmOperationType = @import("lcm_operation_type.zig").LcmOperationType;
const GetSolNetworkOperationMetadata = @import("get_sol_network_operation_metadata.zig").GetSolNetworkOperationMetadata;
const NsLcmOperationState = @import("ns_lcm_operation_state.zig").NsLcmOperationState;
const GetSolNetworkOperationTaskDetails = @import("get_sol_network_operation_task_details.zig").GetSolNetworkOperationTaskDetails;
const UpdateSolNetworkType = @import("update_sol_network_type.zig").UpdateSolNetworkType;

pub const GetSolNetworkOperationInput = struct {
    /// The identifier of the network operation.
    ns_lcm_op_occ_id: []const u8,

    pub const json_field_names = .{
        .ns_lcm_op_occ_id = "nsLcmOpOccId",
    };
};

pub const GetSolNetworkOperationOutput = struct {
    /// Network operation ARN.
    arn: []const u8,

    /// Error related to this specific network operation occurrence.
    @"error": ?ProblemDetails = null,

    /// ID of this network operation occurrence.
    id: ?[]const u8 = null,

    /// Type of the operation represented by this occurrence.
    lcm_operation_type: ?LcmOperationType = null,

    /// Metadata of this network operation occurrence.
    metadata: ?GetSolNetworkOperationMetadata = null,

    /// ID of the network operation instance.
    ns_instance_id: ?[]const u8 = null,

    /// The state of the network operation.
    operation_state: ?NsLcmOperationState = null,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// All tasks associated with this operation occurrence.
    tasks: ?[]const GetSolNetworkOperationTaskDetails = null,

    /// Type of the update. Only present if the network operation
    /// lcmOperationType is `UPDATE`.
    update_type: ?UpdateSolNetworkType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .@"error" = "error",
        .id = "id",
        .lcm_operation_type = "lcmOperationType",
        .metadata = "metadata",
        .ns_instance_id = "nsInstanceId",
        .operation_state = "operationState",
        .tags = "tags",
        .tasks = "tasks",
        .update_type = "updateType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSolNetworkOperationInput, options: CallOptions) !GetSolNetworkOperationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSolNetworkOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nslcm/v1/ns_lcm_op_occs/");
    try path_buf.appendSlice(allocator, input.ns_lcm_op_occ_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSolNetworkOperationOutput {
    var result: GetSolNetworkOperationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSolNetworkOperationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
