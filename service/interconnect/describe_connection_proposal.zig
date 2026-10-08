const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provider = @import("provider.zig").Provider;

pub const DescribeConnectionProposalInput = struct {
    /// An Activation Key that was generated on a supported partner's portal. This
    /// key captures the desired parameters from the initial creation request.
    activation_key: []const u8,

    pub const json_field_names = .{
        .activation_key = "activationKey",
    };
};

pub const DescribeConnectionProposalOutput = struct {
    /// The bandwidth of the proposed Connection.
    bandwidth: []const u8,

    /// The identifier of the Environment upon which the Connection would be placed
    /// if this proposal were accepted.
    environment_id: []const u8,

    /// The partner specific location distinguisher of the specific Environment of
    /// the proposal.
    location: []const u8,

    /// The partner provider of the specific Environment of the proposal.
    provider: ?Provider = null,

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .environment_id = "environmentId",
        .location = "location",
        .provider = "provider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectionProposalInput, options: CallOptions) !DescribeConnectionProposalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "interconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectionProposalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("interconnect", "Interconnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Interconnect.DescribeConnectionProposal");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectionProposalOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeConnectionProposalOutput, body, allocator);
}
