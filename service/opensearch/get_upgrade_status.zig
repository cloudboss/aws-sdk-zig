const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpgradeStatus = @import("upgrade_status.zig").UpgradeStatus;
const UpgradeStep = @import("upgrade_step.zig").UpgradeStep;

pub const GetUpgradeStatusInput = struct {
    /// The domain of the domain to get upgrade status information for.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetUpgradeStatusOutput = struct {
    /// The status of the current step that an upgrade is on.
    step_status: ?UpgradeStatus = null,

    /// A string that describes the update.
    upgrade_name: ?[]const u8 = null,

    /// One of three steps that an upgrade or upgrade eligibility check goes
    /// through.
    upgrade_step: ?UpgradeStep = null,

    pub const json_field_names = .{
        .step_status = "StepStatus",
        .upgrade_name = "UpgradeName",
        .upgrade_step = "UpgradeStep",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUpgradeStatusInput, options: CallOptions) !GetUpgradeStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUpgradeStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/upgradeDomain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUpgradeStatusOutput {
    const result: GetUpgradeStatusOutput = try aws.json.parseJsonObject(
        GetUpgradeStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
