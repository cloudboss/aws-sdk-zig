const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePermissionStatementInput = struct {
    /// Idempotency token for the request
    client_token: ?[]const u8 = null,

    /// Console VPC endpoint identifier
    console_source_vpce: ?[]const u8 = null,

    /// Principal to exclude from the permission statement
    excluded_principal: ?[]const u8 = null,

    /// AWS region where the VPC and VPC endpoint reside
    /// Required when sourceVpc or signinSourceVpce/consoleSourceVpce is provided
    requested_region: ?[]const u8 = null,

    /// SignIn VPC endpoint identifier
    signin_source_vpce: ?[]const u8 = null,

    /// Source IP address
    source_ip: ?[]const u8 = null,

    /// VPC identifier to restrict console access
    source_vpc: ?[]const u8 = null,

    /// Source IP address within VPC
    vpc_source_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .console_source_vpce = "consoleSourceVpce",
        .excluded_principal = "excludedPrincipal",
        .requested_region = "requestedRegion",
        .signin_source_vpce = "signinSourceVpce",
        .source_ip = "sourceIp",
        .source_vpc = "sourceVpc",
        .vpc_source_ip = "vpcSourceIp",
    };
};

pub const PutResourcePermissionStatementOutput = struct {
    /// Unique identifier for the created permission statement
    statement_id: []const u8,

    pub const json_field_names = .{
        .statement_id = "statementId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePermissionStatementInput, options: CallOptions) !PutResourcePermissionStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePermissionStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signin", "Signin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/put-resource-permission-statement";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.console_source_vpce) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"consoleSourceVpce\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.excluded_principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"excludedPrincipal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requested_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestedRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.signin_source_vpce) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signinSourceVpce\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceIp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_vpc) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceVpc\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_source_ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcSourceIp\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePermissionStatementOutput {
    const result: PutResourcePermissionStatementOutput = try aws.json.parseJsonObject(
        PutResourcePermissionStatementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
