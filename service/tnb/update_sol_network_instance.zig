const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateSolNetworkModify = @import("update_sol_network_modify.zig").UpdateSolNetworkModify;
const UpdateSolNetworkServiceData = @import("update_sol_network_service_data.zig").UpdateSolNetworkServiceData;
const UpdateSolNetworkType = @import("update_sol_network_type.zig").UpdateSolNetworkType;

pub const UpdateSolNetworkInstanceInput = struct {
    /// Identifies the network function information parameters and/or the
    /// configurable
    /// properties of the network function to be modified.
    ///
    /// Include this property only if the update type is `MODIFY_VNF_INFORMATION`.
    modify_vnf_info_data: ?UpdateSolNetworkModify = null,

    /// ID of the network instance.
    ns_instance_id: []const u8,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. When you use this API, the tags
    /// are only applied to the network operation that is created. These tags are
    /// not applied to the network instance. Use tags to search and filter your
    /// resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Identifies the network service descriptor and the configurable
    /// properties of the descriptor, to be used for the update.
    ///
    /// Include this property only if the update type is `UPDATE_NS`.
    update_ns: ?UpdateSolNetworkServiceData = null,

    /// The type of update.
    ///
    /// * Use the `MODIFY_VNF_INFORMATION` update type, to update a specific network
    ///   function
    /// configuration, in the network instance.
    ///
    /// * Use the `UPDATE_NS` update type, to update the network instance to a
    /// new network service descriptor.
    update_type: UpdateSolNetworkType,

    pub const json_field_names = .{
        .modify_vnf_info_data = "modifyVnfInfoData",
        .ns_instance_id = "nsInstanceId",
        .tags = "tags",
        .update_ns = "updateNs",
        .update_type = "updateType",
    };
};

pub const UpdateSolNetworkInstanceOutput = struct {
    /// The identifier of the network operation.
    ns_lcm_op_occ_id: ?[]const u8 = null,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. When you use this API, the tags
    /// are only applied to the network operation that is created. These tags are
    /// not applied to the network instance. Use tags to search and filter your
    /// resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ns_lcm_op_occ_id = "nsLcmOpOccId",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSolNetworkInstanceInput, options: CallOptions) !UpdateSolNetworkInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSolNetworkInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sol/nslcm/v1/ns_instances/");
    try path_buf.appendSlice(allocator, input.ns_instance_id);
    try path_buf.appendSlice(allocator, "/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.modify_vnf_info_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modifyVnfInfoData\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.update_ns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateNs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"updateType\":");
    try aws.json.writeValue(@TypeOf(input.update_type), input.update_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSolNetworkInstanceOutput {
    var result: UpdateSolNetworkInstanceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSolNetworkInstanceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
