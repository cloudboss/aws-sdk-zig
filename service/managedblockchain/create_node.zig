const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NodeConfiguration = @import("node_configuration.zig").NodeConfiguration;

pub const CreateNodeInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the operation. An idempotent operation completes no more than
    /// one time. This identifier is required only if you make a service request
    /// directly using an HTTP client. It is generated automatically if you use an
    /// Amazon Web Services SDK or the CLI.
    client_request_token: []const u8,

    /// The unique identifier of the member that owns this node.
    ///
    /// Applies only to Hyperledger Fabric.
    member_id: ?[]const u8 = null,

    /// The unique identifier of the network for the node.
    ///
    /// Ethereum public networks have the following `NetworkId`s:
    ///
    /// * `n-ethereum-mainnet`
    network_id: []const u8,

    /// The properties of a node configuration.
    node_configuration: NodeConfiguration,

    /// Tags to assign to the node.
    ///
    /// Each tag consists of a key and an optional value. You can specify
    /// multiple key-value pairs in a single request with an overall maximum of 50
    /// tags
    /// allowed per resource.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .member_id = "MemberId",
        .network_id = "NetworkId",
        .node_configuration = "NodeConfiguration",
        .tags = "Tags",
    };
};

pub const CreateNodeOutput = struct {
    /// The unique identifier of the node.
    node_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .node_id = "NodeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNodeInput, options: CallOptions) !CreateNodeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/nodes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (input.member_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MemberId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NodeConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.node_configuration), input.node_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNodeOutput {
    var result: CreateNodeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateNodeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
