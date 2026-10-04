const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Job = @import("job.zig").Job;

pub const AssociateSourceNetworkStackInput = struct {
    /// CloudFormation template to associate with a Source Network.
    cfn_stack_name: []const u8,

    /// The Source Network ID to associate with CloudFormation template.
    source_network_id: []const u8,

    pub const json_field_names = .{
        .cfn_stack_name = "cfnStackName",
        .source_network_id = "sourceNetworkID",
    };
};

pub const AssociateSourceNetworkStackOutput = struct {
    /// The Source Network association Job.
    job: ?Job = null,

    pub const json_field_names = .{
        .job = "job",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSourceNetworkStackInput, options: CallOptions) !AssociateSourceNetworkStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSourceNetworkStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/AssociateSourceNetworkStack";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"cfnStackName\":");
    try aws.json.writeValue(@TypeOf(input.cfn_stack_name), input.cfn_stack_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceNetworkID\":");
    try aws.json.writeValue(@TypeOf(input.source_network_id), input.source_network_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSourceNetworkStackOutput {
    const result: AssociateSourceNetworkStackOutput = try aws.json.parseJsonObject(
        AssociateSourceNetworkStackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
