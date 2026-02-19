const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const serde = @import("serde.zig");

pub const ModifyLaunchTemplateInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the
    /// request. If a client token isn't specified, a randomly generated token is
    /// used in the
    /// request to ensure idempotency.
    ///
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    ///
    /// Constraint: Maximum 128 ASCII characters.
    client_token: ?[]const u8 = null,

    /// The version number of the launch template to set as the default version.
    default_version: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the launch template.
    ///
    /// You must specify either the launch template ID or the launch template name,
    /// but not
    /// both.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    ///
    /// You must specify either the launch template ID or the launch template name,
    /// but not
    /// both.
    launch_template_name: ?[]const u8 = null,
};

pub const ModifyLaunchTemplateOutput = struct {
    /// Information about the launch template.
    launch_template: ?LaunchTemplate = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyLaunchTemplateOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyLaunchTemplateInput, options: Options) !ModifyLaunchTemplateOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyLaunchTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyLaunchTemplate&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.default_version) |v| {
        try body_buf.appendSlice(alloc, "&SetDefaultVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_template_id) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_template_name) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateName=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyLaunchTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyLaunchTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "launchTemplate")) {
                    result.launch_template = try serde.deserializeLaunchTemplate(&reader, alloc);
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
