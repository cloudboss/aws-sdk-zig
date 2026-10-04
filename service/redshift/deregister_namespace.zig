const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NamespaceIdentifierUnion = @import("namespace_identifier_union.zig").NamespaceIdentifierUnion;
const NamespaceRegistrationStatus = @import("namespace_registration_status.zig").NamespaceRegistrationStatus;
const serde = @import("serde.zig");

pub const DeregisterNamespaceInput = struct {
    /// An array containing the ID of the consumer account
    /// that you want to deregister the cluster or serverless namespace from.
    consumer_identifiers: []const []const u8,

    /// The unique identifier of the cluster or
    /// serverless namespace that you want to deregister.
    namespace_identifier: NamespaceIdentifierUnion,
};

pub const DeregisterNamespaceOutput = struct {
    /// The registration status of the cluster or
    /// serverless namespace.
    status: ?NamespaceRegistrationStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterNamespaceInput, options: CallOptions) !DeregisterNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeregisterNamespace&Version=2012-12-01");
    for (input.consumer_identifiers, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ConsumerIdentifiers.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    switch (input.namespace_identifier) {
        .provisioned_identifier => |u_0| {
            if (u_0) |v_0| {
                try body_buf.appendSlice(allocator, "&NamespaceIdentifier.ProvisionedIdentifier.ClusterIdentifier=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, v_0.cluster_identifier);
            }
        },
        .serverless_identifier => |u_0| {
            if (u_0) |v_0| {
                try body_buf.appendSlice(allocator, "&NamespaceIdentifier.ServerlessIdentifier.NamespaceIdentifier=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, v_0.namespace_identifier);
                try body_buf.appendSlice(allocator, "&NamespaceIdentifier.ServerlessIdentifier.WorkgroupIdentifier=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, v_0.workgroup_identifier);
            }
        },
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterNamespaceOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeregisterNamespaceResult")) break;
            },
            else => {},
        }
    }

    var result: DeregisterNamespaceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = NamespaceRegistrationStatus.fromWireName(try reader.readElementText());
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
