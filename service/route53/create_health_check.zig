const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HealthCheckConfig = @import("health_check_config.zig").HealthCheckConfig;
const HealthCheck = @import("health_check.zig").HealthCheck;
const serde = @import("serde.zig");

pub const CreateHealthCheckInput = struct {
    /// A unique string that identifies the request and that allows you to retry a
    /// failed
    /// `CreateHealthCheck` request without the risk of creating two identical
    /// health checks:
    ///
    /// * If you send a `CreateHealthCheck` request with the same
    /// `CallerReference` and settings as a previous request, and if the
    /// health check doesn't exist, Amazon Route 53 creates the health check. If the
    /// health check does exist, Route 53 returns the health check configuration in
    /// the
    /// response.
    ///
    /// * If you send a `CreateHealthCheck` request with the same
    /// `CallerReference` as a deleted health check, regardless of the
    /// settings, Route 53 returns a `HealthCheckAlreadyExists` error.
    ///
    /// * If you send a `CreateHealthCheck` request with the same
    /// `CallerReference` as an existing health check but with different
    /// settings, Route 53 returns a `HealthCheckAlreadyExists` error.
    ///
    /// * If you send a `CreateHealthCheck` request with a unique
    /// `CallerReference` but settings identical to an existing health
    /// check, Route 53 creates the health check.
    ///
    /// Route 53 does not store the `CallerReference` for a deleted health check
    /// indefinitely.
    /// The `CallerReference` for a deleted health check will be deleted after a
    /// number of days.
    caller_reference: []const u8,

    /// A complex type that contains settings for a new health check.
    health_check_config: HealthCheckConfig,
};

pub const CreateHealthCheckOutput = struct {
    /// A complex type that contains identifying information about the health check.
    health_check: ?HealthCheck = null,

    /// The unique URL representing the new health check.
    location: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHealthCheckInput, options: CallOptions) !CreateHealthCheckOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHealthCheckInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/healthcheck";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateHealthCheckRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    try body_buf.appendSlice(allocator, "<HealthCheckConfig>");
    try serde.serializeHealthCheckConfig(allocator, &body_buf, input.health_check_config);
    try body_buf.appendSlice(allocator, "</HealthCheckConfig>");
    try body_buf.appendSlice(allocator, "</CreateHealthCheckRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHealthCheckOutput {
    var result: CreateHealthCheckOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "HealthCheck")) {
                    result.health_check = try serde.deserializeHealthCheck(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
