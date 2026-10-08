const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const Project = @import("project.zig").Project;

pub const CreateProjectInput = struct {
    /// Sets the execution timeout value (in minutes) for a project. All test runs
    /// in this project use the
    /// specified execution timeout value unless overridden when scheduling a run.
    default_job_timeout_minutes: ?i32 = null,

    /// A set of environment variables which are used by default for all runs in the
    /// project.
    /// These environment variables are applied to the test run during the execution
    /// of a test spec file.
    ///
    /// For more information about using test spec files, please see
    /// [Custom test environments
    /// ](https://docs.aws.amazon.com/devicefarm/latest/developerguide/custom-test-environments.html) in *AWS Device
    /// Farm.*
    environment_variables: ?[]const EnvironmentVariable = null,

    /// An IAM role to be assumed by the test host for all runs in the project.
    execution_role_arn: ?[]const u8 = null,

    /// The project's name.
    name: []const u8,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .default_job_timeout_minutes = "defaultJobTimeoutMinutes",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .vpc_config = "vpcConfig",
    };
};

pub const CreateProjectOutput = struct {
    /// The newly created project.
    project: ?Project = null,

    pub const json_field_names = .{
        .project = "project",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectInput, options: CallOptions) !CreateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProjectOutput, body, allocator);
}
