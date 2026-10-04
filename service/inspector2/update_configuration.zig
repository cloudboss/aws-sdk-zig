const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Ec2Configuration = @import("ec_2_configuration.zig").Ec2Configuration;
const EcrConfiguration = @import("ecr_configuration.zig").EcrConfiguration;
const UpdateConfigurationInheritance = @import("update_configuration_inheritance.zig").UpdateConfigurationInheritance;

pub const UpdateConfigurationInput = struct {
    /// The 12-digit Amazon Web Services account ID of the member account whose scan
    /// configuration you want
    /// to update. When specified, you must be the delegated administrator for this
    /// member
    /// account. If not specified, the operation updates your own configuration and
    /// propagates changes to any member accounts that have not been individually
    /// configured.
    account_id: ?[]const u8 = null,

    /// Specifies how the Amazon EC2 automated scan will be updated for your
    /// environment.
    ec_2_configuration: ?Ec2Configuration = null,

    /// Specifies how the ECR automated re-scan will be updated for your
    /// environment.
    ecr_configuration: ?EcrConfiguration = null,

    /// Specifies which scan-type configurations to reset to the delegated
    /// administrator's
    /// inherited values for the targeted member account. Each member of this
    /// structure is
    /// independently optional. When specified, `ec2Configuration` and
    /// `ecrConfiguration` must be absent, and `accountId` must also be
    /// present. Only `INHERIT_FROM_ADMIN` is valid for each member. If not
    /// specified,
    /// the operation uses the `ec2Configuration` and `ecrConfiguration`
    /// parameters instead.
    update_configuration_inheritance: ?UpdateConfigurationInheritance = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .ec_2_configuration = "ec2Configuration",
        .ecr_configuration = "ecrConfiguration",
        .update_configuration_inheritance = "updateConfigurationInheritance",
    };
};

pub const UpdateConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConfigurationInput, options: CallOptions) !UpdateConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ec_2_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ec2Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ecr_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ecrConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.update_configuration_inheritance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateConfigurationInheritance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateConfigurationOutput = .{};

    return result;
}
