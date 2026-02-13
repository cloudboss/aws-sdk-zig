const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RegisteredInstance = @import("registered_instance.zig").RegisteredInstance;
const serde = @import("serde.zig");

/// Enable Amazon EC2 instances running in an SQL Server High Availability
/// cluster for SQL Server High Availability
/// instance standby detection monitoring. Once enabled, Amazon Web Services
/// monitors the metadata for
/// the instances to determine whether they are active or standby nodes in the
/// SQL Server High Availability cluster.
/// If the instances are determined to be standby failover nodes, Amazon Web
/// Services
/// automatically applies SQL Server licensing fee waiver for those instances.
///
/// To register an instance, it must be running a Windows SQL Server
/// license-included
/// AMI and have the Amazon Web Services Systems Manager agent installed and
/// running. Only Windows Server 2019 and later
/// and SQL Server (Standard and Enterprise editions) 2017 and later are
/// supported. For more
/// information, see [
/// Prerequisites for using SQL Server High Availability instance standby
/// detection](https://docs.aws.amazon.com/sql-server-ec2/latest/userguide/prerequisites-and-requirements.html).
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *EnableInstanceSqlHaStandbyDetectionsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: EnableInstanceSqlHaStandbyDetectionsInput, options: Options) !EnableInstanceSqlHaStandbyDetectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: EnableInstanceSqlHaStandbyDetectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=EnableInstanceSqlHaStandbyDetections&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.instance_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.sql_server_credentials) |v| {
        try body_buf.appendSlice(alloc, "&SqlServerCredentials=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !EnableInstanceSqlHaStandbyDetectionsOutput {
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
                    result.instances = try serde.deserializeRegisteredInstanceList(&reader, alloc, "item");
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
