const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HealthCheckObservation = @import("health_check_observation.zig").HealthCheckObservation;
const serde = @import("serde.zig");

pub const GetHealthCheckStatusInput = struct {
    /// The ID for the health check that you want the current status for. When you
    /// created the
    /// health check, `CreateHealthCheck` returned the ID in the response, in the
    /// `HealthCheckId` element.
    ///
    /// If you want to check the status of a calculated health check, you must use
    /// the
    /// Amazon Route 53 console or the CloudWatch console. You can't use
    /// `GetHealthCheckStatus` to get the status of a calculated health
    /// check.
    health_check_id: []const u8,
};

pub const GetHealthCheckStatusOutput = struct {
    /// A list that contains one `HealthCheckObservation` element for each Amazon
    /// Route 53 health checker that is reporting a status about the health check
    /// endpoint.
    health_check_observations: ?[]const HealthCheckObservation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHealthCheckStatusInput, options: CallOptions) !GetHealthCheckStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetHealthCheckStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/healthcheck/");
    try path_buf.appendSlice(allocator, input.health_check_id);
    try path_buf.appendSlice(allocator, "/status");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHealthCheckStatusOutput {
    var result: GetHealthCheckStatusOutput = undefined;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthCheckObservations")) {
                    result.health_check_observations = try serde.deserializeHealthCheckObservations(allocator, &reader, "HealthCheckObservation");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
