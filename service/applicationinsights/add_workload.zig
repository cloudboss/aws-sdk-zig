const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkloadConfiguration = @import("workload_configuration.zig").WorkloadConfiguration;

pub const AddWorkloadInput = struct {
    /// The name of the component.
    component_name: []const u8,

    /// The name of the resource group.
    resource_group_name: []const u8,

    /// The configuration settings of the workload. The value is the escaped JSON of
    /// the configuration.
    workload_configuration: WorkloadConfiguration,

    pub const json_field_names = .{
        .component_name = "ComponentName",
        .resource_group_name = "ResourceGroupName",
        .workload_configuration = "WorkloadConfiguration",
    };
};

pub const AddWorkloadOutput = struct {
    /// The configuration settings of the workload. The value is the escaped JSON of
    /// the configuration.
    workload_configuration: ?WorkloadConfiguration = null,

    /// The ID of the workload.
    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .workload_configuration = "WorkloadConfiguration",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddWorkloadInput, options: CallOptions) !AddWorkloadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "applicationinsights", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddWorkloadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.AddWorkload");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddWorkloadOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddWorkloadOutput, body, allocator);
}
