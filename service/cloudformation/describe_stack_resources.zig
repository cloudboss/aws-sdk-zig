const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackResource = @import("stack_resource.zig").StackResource;
const serde = @import("serde.zig");

pub const DescribeStackResourcesInput = struct {
    /// The logical name of the resource as specified in the template.
    logical_resource_id: ?[]const u8 = null,

    /// The name or unique identifier that corresponds to a physical instance ID of
    /// a resource
    /// supported by CloudFormation.
    ///
    /// For example, for an Amazon Elastic Compute Cloud (EC2) instance,
    /// `PhysicalResourceId` corresponds to the `InstanceId`. You can pass the
    /// EC2 `InstanceId` to `DescribeStackResources` to find which stack the
    /// instance belongs to and what other resources are part of the stack.
    ///
    /// Required: Conditional. If you don't specify `PhysicalResourceId`, you must
    /// specify `StackName`.
    physical_resource_id: ?[]const u8 = null,

    /// The name or the unique stack ID that is associated with the stack, which
    /// aren't always
    /// interchangeable:
    ///
    /// * Running stacks: You can specify either the stack's name or its unique
    ///   stack ID.
    ///
    /// * Deleted stacks: You must specify the unique stack ID.
    ///
    /// Required: Conditional. If you don't specify `StackName`, you must specify
    /// `PhysicalResourceId`.
    stack_name: ?[]const u8 = null,
};

pub const DescribeStackResourcesOutput = struct {
    /// A list of `StackResource` structures.
    stack_resources: ?[]const StackResource = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStackResourcesInput, options: CallOptions) !DescribeStackResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStackResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeStackResources&Version=2010-05-15");
    if (input.logical_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&LogicalResourceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.physical_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&PhysicalResourceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStackResourcesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeStackResourcesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeStackResourcesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StackResources")) {
                    result.stack_resources = try serde.deserializeStackResources(allocator, &reader, "member");
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
