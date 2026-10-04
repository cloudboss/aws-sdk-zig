const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContactFlowModuleAliasInfo = @import("contact_flow_module_alias_info.zig").ContactFlowModuleAliasInfo;

pub const DescribeContactFlowModuleAliasInput = struct {
    /// The identifier of the alias.
    alias_id: []const u8,

    /// The identifier of the flow module.
    contact_flow_module_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .contact_flow_module_id = "ContactFlowModuleId",
        .instance_id = "InstanceId",
    };
};

pub const DescribeContactFlowModuleAliasOutput = struct {
    /// Information about the flow module alias.
    contact_flow_module_alias: ?ContactFlowModuleAliasInfo = null,

    pub const json_field_names = .{
        .contact_flow_module_alias = "ContactFlowModuleAlias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeContactFlowModuleAliasInput, options: CallOptions) !DescribeContactFlowModuleAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeContactFlowModuleAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact-flow-modules/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_flow_module_id);
    try path_buf.appendSlice(allocator, "/alias/");
    try path_buf.appendSlice(allocator, input.alias_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeContactFlowModuleAliasOutput {
    const result: DescribeContactFlowModuleAliasOutput = try aws.json.parseJsonObject(
        DescribeContactFlowModuleAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
