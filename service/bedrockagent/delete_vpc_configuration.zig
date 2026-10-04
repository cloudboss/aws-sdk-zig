const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConfigurationStatus = @import("vpc_configuration_status.zig").VpcConfigurationStatus;

pub const DeleteVpcConfigurationInput = struct {
    /// The unique identifier of the knowledge base that owns the VPC configuration.
    knowledge_base_id: []const u8,

    /// The unique identifier of the VPC configuration to delete.
    vpc_configuration_id: []const u8,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .vpc_configuration_id = "vpcConfigurationId",
    };
};

pub const DeleteVpcConfigurationOutput = struct {
    /// The current status of the VPC configuration. Immediately after a delete
    /// request this is `DELETING`.
    status: VpcConfigurationStatus,

    /// The unique identifier of the VPC configuration being deleted.
    vpc_configuration_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .vpc_configuration_id = "vpcConfigurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVpcConfigurationInput, options: CallOptions) !DeleteVpcConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVpcConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/vpcconfigurations/");
    try path_buf.appendSlice(allocator, input.vpc_configuration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVpcConfigurationOutput {
    const result: DeleteVpcConfigurationOutput = try aws.json.parseJsonObject(
        DeleteVpcConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
