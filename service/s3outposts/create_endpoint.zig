const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointAccessType = @import("endpoint_access_type.zig").EndpointAccessType;

pub const CreateEndpointInput = struct {
    /// The type of access for the network connectivity for the Amazon S3 on
    /// Outposts endpoint. To use
    /// the Amazon Web Services VPC, choose `Private`. To use the endpoint with an
    /// on-premises
    /// network, choose `CustomerOwnedIp`. If you choose
    /// `CustomerOwnedIp`, you must also provide the customer-owned IP address
    /// pool (CoIP pool).
    ///
    /// `Private` is the default access type value.
    access_type: ?EndpointAccessType = null,

    /// The ID of the customer-owned IPv4 address pool (CoIP pool) for the endpoint.
    /// IP addresses
    /// are allocated from this pool for the endpoint.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// The ID of the Outposts.
    outpost_id: []const u8,

    /// The ID of the security group to use with the endpoint.
    security_group_id: []const u8,

    /// The ID of the subnet in the selected VPC. The endpoint subnet must belong to
    /// the Outpost
    /// that has Amazon S3 on Outposts provisioned.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .customer_owned_ipv_4_pool = "CustomerOwnedIpv4Pool",
        .outpost_id = "OutpostId",
        .security_group_id = "SecurityGroupId",
        .subnet_id = "SubnetId",
    };
};

pub const CreateEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointInput, options: CallOptions) !CreateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3-outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-outposts", "S3Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/S3Outposts/CreateEndpoint";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customer_owned_ipv_4_pool) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomerOwnedIpv4Pool\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutpostId\":");
    try aws.json.writeValue(@TypeOf(input.outpost_id), input.outpost_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityGroupId\":");
    try aws.json.writeValue(@TypeOf(input.security_group_id), input.security_group_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SubnetId\":");
    try aws.json.writeValue(@TypeOf(input.subnet_id), input.subnet_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointOutput {
    const result: CreateEndpointOutput = try aws.json.parseJsonObject(
        CreateEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
