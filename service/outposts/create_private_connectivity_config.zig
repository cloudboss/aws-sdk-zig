const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcInformation = @import("vpc_information.zig").VpcInformation;
const PrivateConnectivityConfig = @import("private_connectivity_config.zig").PrivateConnectivityConfig;

pub const CreatePrivateConnectivityConfigInput = struct {
    /// The ID or ARN of the Outpost.
    outpost_id: []const u8,

    /// Information about the VPC used for private connectivity, including the VPC,
    /// its subnets,
    /// and an associated VPC endpoint. You can specify at most one entry.
    vpc_information_list: []const VpcInformation,

    pub const json_field_names = .{
        .outpost_id = "OutpostId",
        .vpc_information_list = "VpcInformationList",
    };
};

pub const CreatePrivateConnectivityConfigOutput = struct {
    /// The ID of the Outpost.
    outpost_id: ?[]const u8 = null,

    /// The private connectivity configuration for the Outpost.
    private_connectivity_config: ?PrivateConnectivityConfig = null,

    pub const json_field_names = .{
        .outpost_id = "OutpostId",
        .private_connectivity_config = "PrivateConnectivityConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePrivateConnectivityConfigInput, options: CallOptions) !CreatePrivateConnectivityConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePrivateConnectivityConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/outposts/");
    try path_buf.appendSlice(allocator, input.outpost_id);
    try path_buf.appendSlice(allocator, "/privateConnectivity");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcInformationList\":");
    try aws.json.writeValue(@TypeOf(input.vpc_information_list), input.vpc_information_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePrivateConnectivityConfigOutput {
    const result: CreatePrivateConnectivityConfigOutput = try aws.json.parseJsonObject(
        CreatePrivateConnectivityConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
