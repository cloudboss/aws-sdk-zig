const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegisteredInstance = @import("registered_instance.zig").RegisteredInstance;
const serde = @import("serde.zig");

pub const EnableInstanceSqlHaStandbyDetectionsInput = struct {
    /// Checks whether you have the required permissions for the action,
    /// without actually making the request, and provides an error response. If you
    /// have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise,
    /// it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of the instances to enable for SQL Server High Availability standby
    /// detection monitoring.
    instance_ids: []const []const u8,

    /// The ARN of the Secrets Manager secret containing the SQL Server access
    /// credentials. The specified
    /// secret must contain valid SQL Server credentials for the specified
    /// instances. If not specified,
    /// deafult local user credentials will be used by the Amazon Web Services
    /// Systems Manager agent. To enable
    /// instances with different credentials, you must make separate requests.
    sql_server_credentials: ?[]const u8 = null,
};

pub const EnableInstanceSqlHaStandbyDetectionsOutput = struct {
    /// Information about the instances that were enabled for SQL Server High
    /// Availability standby
    /// detection monitoring.
    instances: ?[]const RegisteredInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableInstanceSqlHaStandbyDetectionsInput, options: CallOptions) !EnableInstanceSqlHaStandbyDetectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableInstanceSqlHaStandbyDetectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnableInstanceSqlHaStandbyDetections&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    for (input.instance_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    if (input.sql_server_credentials) |v| {
        try body_buf.appendSlice(allocator, "&SqlServerCredentials=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableInstanceSqlHaStandbyDetectionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: EnableInstanceSqlHaStandbyDetectionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceSet")) {
                    result.instances = try serde.deserializeRegisteredInstanceList(allocator, &reader, "item");
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
