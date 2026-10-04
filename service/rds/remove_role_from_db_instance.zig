const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RemoveRoleFromDBInstanceInput = struct {
    /// The name of the DB instance to disassociate the IAM role from.
    db_instance_identifier: []const u8,

    /// The name of the feature for the DB instance that the IAM role is to be
    /// disassociated from. For information about supported feature names, see
    /// `DBEngineVersion`.
    feature_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role to disassociate from the DB
    /// instance, for example, `arn:aws:iam::123456789012:role/AccessRole`.
    role_arn: []const u8,
};

pub const RemoveRoleFromDBInstanceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveRoleFromDBInstanceInput, options: CallOptions) !RemoveRoleFromDBInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveRoleFromDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RemoveRoleFromDBInstance&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    try body_buf.appendSlice(allocator, "&FeatureName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.feature_name);
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveRoleFromDBInstanceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: RemoveRoleFromDBInstanceOutput = .{};

    return result;
}
