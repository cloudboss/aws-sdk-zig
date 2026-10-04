const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtocolsListData = @import("protocols_list_data.zig").ProtocolsListData;

pub const GetProtocolsListInput = struct {
    /// Specifies whether the list to retrieve is a default list owned by Firewall
    /// Manager.
    default_list: ?bool = null,

    /// The ID of the Firewall Manager protocols list that you want the details for.
    list_id: []const u8,

    pub const json_field_names = .{
        .default_list = "DefaultList",
        .list_id = "ListId",
    };
};

pub const GetProtocolsListOutput = struct {
    /// Information about the specified Firewall Manager protocols list.
    protocols_list: ?ProtocolsListData = null,

    /// The Amazon Resource Name (ARN) of the specified protocols list.
    protocols_list_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .protocols_list = "ProtocolsList",
        .protocols_list_arn = "ProtocolsListArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProtocolsListInput, options: CallOptions) !GetProtocolsListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProtocolsListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetProtocolsList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProtocolsListOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetProtocolsListOutput, body, allocator);
}
