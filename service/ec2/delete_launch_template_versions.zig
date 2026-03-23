const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DeleteLaunchTemplateVersionsResponseSuccessItem = @import("delete_launch_template_versions_response_success_item.zig").DeleteLaunchTemplateVersionsResponseSuccessItem;
const DeleteLaunchTemplateVersionsResponseErrorItem = @import("delete_launch_template_versions_response_error_item.zig").DeleteLaunchTemplateVersionsResponseErrorItem;
const serde = @import("serde.zig");

pub const DeleteLaunchTemplateVersionsInput = struct {
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

    /// The version numbers of one or more launch template versions to delete. You
    /// can specify
    /// up to 200 launch template version numbers.
    versions: []const []const u8,
};

pub const DeleteLaunchTemplateVersionsOutput = struct {
    /// Information about the launch template versions that were successfully
    /// deleted.
    successfully_deleted_launch_template_versions: ?[]const DeleteLaunchTemplateVersionsResponseSuccessItem = null,

    /// Information about the launch template versions that could not be deleted.
    unsuccessfully_deleted_launch_template_versions: ?[]const DeleteLaunchTemplateVersionsResponseErrorItem = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLaunchTemplateVersionsInput, options: CallOptions) !DeleteLaunchTemplateVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteLaunchTemplateVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DeleteLaunchTemplateVersions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_template_id) |v| {
        try body_buf.appendSlice(allocator, "&LaunchTemplateId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.launch_template_name) |v| {
        try body_buf.appendSlice(allocator, "&LaunchTemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    for (input.versions, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateVersion.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteLaunchTemplateVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DeleteLaunchTemplateVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "successfullyDeletedLaunchTemplateVersionSet")) {
                    result.successfully_deleted_launch_template_versions = try serde.deserializeDeleteLaunchTemplateVersionsResponseSuccessSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessfullyDeletedLaunchTemplateVersionSet")) {
                    result.unsuccessfully_deleted_launch_template_versions = try serde.deserializeDeleteLaunchTemplateVersionsResponseErrorSet(allocator, &reader, "item");
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
