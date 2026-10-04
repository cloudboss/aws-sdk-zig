const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointAccess = @import("endpoint_access.zig").EndpointAccess;

pub const CreateEndpointAccessInput = struct {
    /// The name of the VPC endpoint. An endpoint name must contain 1-30 characters.
    /// Valid characters are A-Z, a-z, 0-9, and hyphen(-). The first character must
    /// be a letter. The name can't contain two consecutive hyphens or end with a
    /// hyphen.
    endpoint_name: []const u8,

    /// The owner Amazon Web Services account for the Amazon Redshift Serverless
    /// workgroup.
    owner_account: ?[]const u8 = null,

    /// The unique identifers of subnets from which Amazon Redshift Serverless
    /// chooses one to deploy a VPC endpoint.
    subnet_ids: []const []const u8,

    /// The unique identifiers of the security group that defines the ports,
    /// protocols, and sources for inbound traffic that you are authorizing into
    /// your endpoint.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// The name of the workgroup to associate with the VPC endpoint.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .endpoint_name = "endpointName",
        .owner_account = "ownerAccount",
        .subnet_ids = "subnetIds",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
        .workgroup_name = "workgroupName",
    };
};

pub const CreateEndpointAccessOutput = struct {
    /// The created VPC endpoint.
    endpoint: ?EndpointAccess = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointAccessInput, options: CallOptions) !CreateEndpointAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.CreateEndpointAccess");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointAccessOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEndpointAccessOutput, body, allocator);
}
