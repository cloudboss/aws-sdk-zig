const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VirtualMachine = @import("virtual_machine.zig").VirtualMachine;

pub const ListVirtualMachinesInput = struct {
    /// The Amazon Resource Name (ARN) of the hypervisor connected to your virtual
    /// machine.
    hypervisor_arn: ?[]const u8 = null,

    /// The maximum number of virtual machines to list.
    max_results: ?i32 = null,

    /// The next item following a partial list of returned resources. For example,
    /// if a request is made to return `maxResults` number of resources, `NextToken`
    /// allows you to return more items in your list starting at the location
    /// pointed to by the next token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hypervisor_arn = "HypervisorArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListVirtualMachinesOutput = struct {
    /// The next item following a partial list of returned resources. For example,
    /// if a request is made to return `maxResults` number of resources, `NextToken`
    /// allows you to return more items in your list starting at the location
    /// pointed to by the next token.
    next_token: ?[]const u8 = null,

    /// A list of your `VirtualMachine` objects, ordered by their Amazon Resource
    /// Names (ARNs).
    virtual_machines: ?[]const VirtualMachine = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .virtual_machines = "VirtualMachines",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVirtualMachinesInput, options: CallOptions) !ListVirtualMachinesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-gateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVirtualMachinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-gateway", "Backup Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "BackupOnPremises_v20210101.ListVirtualMachines");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVirtualMachinesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVirtualMachinesOutput, body, allocator);
}
