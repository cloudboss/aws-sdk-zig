const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventSubscription = @import("event_subscription.zig").EventSubscription;
const serde = @import("serde.zig");

pub const AddSourceIdentifierToSubscriptionInput = struct {
    /// The identifier of the event source to be added.
    ///
    /// Constraints:
    ///
    /// * If the source type is a DB instance, then a `DBInstanceIdentifier` must be
    /// supplied.
    ///
    /// * If the source type is a DB security group, a `DBSecurityGroupName` must be
    /// supplied.
    ///
    /// * If the source type is a DB parameter group, a `DBParameterGroupName` must
    /// be supplied.
    ///
    /// * If the source type is a DB snapshot, a `DBSnapshotIdentifier` must be
    /// supplied.
    source_identifier: []const u8,

    /// The name of the event notification subscription you want to add a source
    /// identifier
    /// to.
    subscription_name: []const u8,
};

pub const AddSourceIdentifierToSubscriptionOutput = struct {
    event_subscription: ?EventSubscription = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddSourceIdentifierToSubscriptionInput, options: CallOptions) !AddSourceIdentifierToSubscriptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddSourceIdentifierToSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AddSourceIdentifierToSubscription&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&SourceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_identifier);
    try body_buf.appendSlice(allocator, "&SubscriptionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.subscription_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddSourceIdentifierToSubscriptionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AddSourceIdentifierToSubscriptionResult")) break;
            },
            else => {},
        }
    }

    var result: AddSourceIdentifierToSubscriptionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EventSubscription")) {
                    result.event_subscription = try serde.deserializeEventSubscription(allocator, &reader);
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
