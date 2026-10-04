const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartSourceNetworkRecoveryRequestNetworkEntry = @import("start_source_network_recovery_request_network_entry.zig").StartSourceNetworkRecoveryRequestNetworkEntry;
const Job = @import("job.zig").Job;

pub const StartSourceNetworkRecoveryInput = struct {
    /// Don't update existing CloudFormation Stack, recover the network using a new
    /// stack.
    deploy_as_new: ?bool = null,

    /// The Source Networks that we want to start a Recovery Job for.
    source_networks: []const StartSourceNetworkRecoveryRequestNetworkEntry,

    /// The tags to be associated with the Source Network recovery Job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .deploy_as_new = "deployAsNew",
        .source_networks = "sourceNetworks",
        .tags = "tags",
    };
};

pub const StartSourceNetworkRecoveryOutput = struct {
    /// The Source Network recovery Job.
    job: ?Job = null,

    pub const json_field_names = .{
        .job = "job",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSourceNetworkRecoveryInput, options: CallOptions) !StartSourceNetworkRecoveryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSourceNetworkRecoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartSourceNetworkRecovery";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deploy_as_new) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deployAsNew\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceNetworks\":");
    try aws.json.writeValue(@TypeOf(input.source_networks), input.source_networks, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSourceNetworkRecoveryOutput {
    var result: StartSourceNetworkRecoveryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSourceNetworkRecoveryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
