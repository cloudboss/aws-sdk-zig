const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubnetGroup = @import("subnet_group.zig").SubnetGroup;

pub const CreateSubnetGroupInput = struct {
    /// A description for the subnet group
    description: ?[]const u8 = null,

    /// A name for the subnet group. This value is stored as a lowercase string.
    subnet_group_name: []const u8,

    /// A list of VPC subnet IDs for the subnet group.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .subnet_group_name = "SubnetGroupName",
        .subnet_ids = "SubnetIds",
    };
};

pub const CreateSubnetGroupOutput = struct {
    /// Represents the output of a *CreateSubnetGroup*
    /// operation.
    subnet_group: ?SubnetGroup = null,

    pub const json_field_names = .{
        .subnet_group = "SubnetGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSubnetGroupInput, options: CallOptions) !CreateSubnetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSubnetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.CreateSubnetGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSubnetGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSubnetGroupOutput, body, allocator);
}
