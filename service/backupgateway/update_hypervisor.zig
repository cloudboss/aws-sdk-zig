const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateHypervisorInput = struct {
    /// The updated host of the hypervisor. This can be either an IP address or a
    /// fully-qualified
    /// domain name (FQDN).
    host: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hypervisor to update.
    hypervisor_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the group of gateways within the requested
    /// log.
    log_group_arn: ?[]const u8 = null,

    /// The updated name for the hypervisor
    name: ?[]const u8 = null,

    /// The updated password for the hypervisor.
    password: ?[]const u8 = null,

    /// The updated username for the hypervisor.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .host = "Host",
        .hypervisor_arn = "HypervisorArn",
        .log_group_arn = "LogGroupArn",
        .name = "Name",
        .password = "Password",
        .username = "Username",
    };
};

pub const UpdateHypervisorOutput = struct {
    /// The Amazon Resource Name (ARN) of the hypervisor you updated.
    hypervisor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hypervisor_arn = "HypervisorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHypervisorInput, options: CallOptions) !UpdateHypervisorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHypervisorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "BackupOnPremises_v20210101.UpdateHypervisor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHypervisorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateHypervisorOutput, body, allocator);
}
