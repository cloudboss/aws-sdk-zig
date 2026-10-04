const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackResourceDrift = @import("stack_resource_drift.zig").StackResourceDrift;
const serde = @import("serde.zig");

pub const DetectStackResourceDriftInput = struct {
    /// The logical name of the resource for which to return drift information.
    logical_resource_id: []const u8,

    /// The name of the stack to which the resource belongs.
    stack_name: []const u8,
};

pub const DetectStackResourceDriftOutput = struct {
    /// Information about whether the resource's actual configuration has drifted
    /// from its
    /// expected template configuration, including actual and expected property
    /// values and any
    /// differences detected.
    stack_resource_drift: ?StackResourceDrift = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectStackResourceDriftInput, options: CallOptions) !DetectStackResourceDriftOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectStackResourceDriftInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DetectStackResourceDrift&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&LogicalResourceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.logical_resource_id);
    try body_buf.appendSlice(allocator, "&StackName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectStackResourceDriftOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DetectStackResourceDriftResult")) break;
            },
            else => {},
        }
    }

    var result: DetectStackResourceDriftOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StackResourceDrift")) {
                    result.stack_resource_drift = try serde.deserializeStackResourceDrift(allocator, &reader);
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
