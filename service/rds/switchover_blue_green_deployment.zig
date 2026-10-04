const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueGreenDeployment = @import("blue_green_deployment.zig").BlueGreenDeployment;
const serde = @import("serde.zig");

pub const SwitchoverBlueGreenDeploymentInput = struct {
    /// The resource ID of the blue/green deployment.
    ///
    /// Constraints:
    ///
    /// * Must match an existing blue/green deployment resource ID.
    blue_green_deployment_identifier: []const u8,

    /// The amount of time, in seconds, for the switchover to complete.
    ///
    /// Default: 300
    ///
    /// If the switchover takes longer than the specified duration, then any changes
    /// are rolled back, and no changes are made to the environments.
    switchover_timeout: ?i32 = null,
};

pub const SwitchoverBlueGreenDeploymentOutput = struct {
    blue_green_deployment: ?BlueGreenDeployment = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SwitchoverBlueGreenDeploymentInput, options: CallOptions) !SwitchoverBlueGreenDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SwitchoverBlueGreenDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SwitchoverBlueGreenDeployment&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&BlueGreenDeploymentIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.blue_green_deployment_identifier);
    if (input.switchover_timeout) |v| {
        try body_buf.appendSlice(allocator, "&SwitchoverTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SwitchoverBlueGreenDeploymentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SwitchoverBlueGreenDeploymentResult")) break;
            },
            else => {},
        }
    }

    var result: SwitchoverBlueGreenDeploymentOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BlueGreenDeployment")) {
                    result.blue_green_deployment = try serde.deserializeBlueGreenDeployment(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
