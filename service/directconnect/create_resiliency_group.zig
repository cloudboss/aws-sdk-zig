const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResiliencyModel = @import("resiliency_model.zig").ResiliencyModel;
const Tag = @import("tag.zig").Tag;
const ResiliencyGroup = @import("resiliency_group.zig").ResiliencyGroup;

pub const CreateResiliencyGroupInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The resiliency model that the resiliency group is intended to meet. The
    /// valid values are
    /// `maximum-resiliency`, `high-resiliency`, and
    /// `basic-resiliency`.
    intended_resiliency_model: ResiliencyModel,

    /// The name of the resiliency group.
    resiliency_group_name: []const u8,

    /// The tags to associate with the resiliency group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .intended_resiliency_model = "intendedResiliencyModel",
        .resiliency_group_name = "resiliencyGroupName",
        .tags = "tags",
    };
};

pub const CreateResiliencyGroupOutput = struct {
    /// Information about the resiliency group.
    resiliency_group: ?ResiliencyGroup = null,

    pub const json_field_names = .{
        .resiliency_group = "resiliencyGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResiliencyGroupInput, options: CallOptions) !CreateResiliencyGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResiliencyGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.CreateResiliencyGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResiliencyGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResiliencyGroupOutput, body, allocator);
}
