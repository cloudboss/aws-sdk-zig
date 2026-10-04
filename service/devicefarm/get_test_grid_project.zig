const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestGridProject = @import("test_grid_project.zig").TestGridProject;

pub const GetTestGridProjectInput = struct {
    /// The ARN of the Selenium testing project, from either CreateTestGridProject
    /// or ListTestGridProjects.
    project_arn: []const u8,

    pub const json_field_names = .{
        .project_arn = "projectArn",
    };
};

pub const GetTestGridProjectOutput = struct {
    /// A TestGridProject.
    test_grid_project: ?TestGridProject = null,

    pub const json_field_names = .{
        .test_grid_project = "testGridProject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTestGridProjectInput, options: CallOptions) !GetTestGridProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTestGridProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.GetTestGridProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTestGridProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTestGridProjectOutput, body, allocator);
}
