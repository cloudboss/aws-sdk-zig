const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestGridVpcConfig = @import("test_grid_vpc_config.zig").TestGridVpcConfig;
const TestGridProject = @import("test_grid_project.zig").TestGridProject;

pub const UpdateTestGridProjectInput = struct {
    /// Human-readable description for the project.
    description: ?[]const u8 = null,

    /// Human-readable name for the project.
    name: ?[]const u8 = null,

    /// ARN of the project to update.
    project_arn: []const u8,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?TestGridVpcConfig = null,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .project_arn = "projectArn",
        .vpc_config = "vpcConfig",
    };
};

pub const UpdateTestGridProjectOutput = struct {
    /// The project, including updated information.
    test_grid_project: ?TestGridProject = null,

    pub const json_field_names = .{
        .test_grid_project = "testGridProject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTestGridProjectInput, options: CallOptions) !UpdateTestGridProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTestGridProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.UpdateTestGridProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTestGridProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTestGridProjectOutput, body, allocator);
}
