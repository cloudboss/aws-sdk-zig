const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConnector = @import("vpc_connector.zig").VpcConnector;

pub const DeleteVpcConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the App Runner VPC connector that you want
    /// to delete.
    ///
    /// The ARN must be a full VPC connector ARN.
    vpc_connector_arn: []const u8,

    pub const json_field_names = .{
        .vpc_connector_arn = "VpcConnectorArn",
    };
};

pub const DeleteVpcConnectorOutput = struct {
    /// A description of the App Runner VPC connector that this request just
    /// deleted.
    vpc_connector: ?VpcConnector = null,

    pub const json_field_names = .{
        .vpc_connector = "VpcConnector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVpcConnectorInput, options: CallOptions) !DeleteVpcConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apprunner", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVpcConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apprunner", "AppRunner", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AppRunner.DeleteVpcConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVpcConnectorOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteVpcConnectorOutput, body, allocator);
}
