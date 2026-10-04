const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlueGreenDeployment = @import("blue_green_deployment.zig").BlueGreenDeployment;
const serde = @import("serde.zig");

pub const DeleteBlueGreenDeploymentInput = struct {
    /// The unique identifier of the blue/green deployment to delete. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match an existing blue/green deployment identifier.
    blue_green_deployment_identifier: []const u8,

    /// Specifies whether to delete the resources in the green environment. You
    /// can't specify this option if the blue/green deployment
    /// [status](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_BlueGreenDeployment.html) is `SWITCHOVER_COMPLETED`.
    delete_target: ?bool = null,
};

pub const DeleteBlueGreenDeploymentOutput = struct {
    blue_green_deployment: ?BlueGreenDeployment = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBlueGreenDeploymentInput, options: CallOptions) !DeleteBlueGreenDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBlueGreenDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteBlueGreenDeployment&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&BlueGreenDeploymentIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.blue_green_deployment_identifier);
    if (input.delete_target) |v| {
        try body_buf.appendSlice(allocator, "&DeleteTarget=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBlueGreenDeploymentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteBlueGreenDeploymentResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteBlueGreenDeploymentOutput = .{};
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
