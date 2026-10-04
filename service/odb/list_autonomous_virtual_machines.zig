const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutonomousVirtualMachineSummary = @import("autonomous_virtual_machine_summary.zig").AutonomousVirtualMachineSummary;

pub const ListAutonomousVirtualMachinesInput = struct {
    /// The unique identifier of the Autonomous VM cluster whose virtual machines
    /// you're listing.
    cloud_autonomous_vm_cluster_id: []const u8,

    /// The maximum number of items to return per page.
    max_results: ?i32 = null,

    /// The pagination token to continue listing from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_autonomous_vm_cluster_id = "cloudAutonomousVmClusterId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAutonomousVirtualMachinesOutput = struct {
    /// The list of Autonomous VMs in the specified Autonomous VM cluster.
    autonomous_virtual_machines: ?[]const AutonomousVirtualMachineSummary = null,

    /// The pagination token from which to continue listing.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .autonomous_virtual_machines = "autonomousVirtualMachines",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutonomousVirtualMachinesInput, options: CallOptions) !ListAutonomousVirtualMachinesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutonomousVirtualMachinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.ListAutonomousVirtualMachines");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutonomousVirtualMachinesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAutonomousVirtualMachinesOutput, body, allocator);
}
