const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ImageCriterion = @import("image_criterion.zig").ImageCriterion;
const ManagedBy = @import("managed_by.zig").ManagedBy;
const serde = @import("serde.zig");

pub const GetAllowedImagesSettingsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,
};

pub const GetAllowedImagesSettingsOutput = struct {
    /// The list of criteria for images that are discoverable and usable in the
    /// account in the
    /// specified Amazon Web Services Region.
    image_criteria: ?[]const ImageCriterion = null,

    /// The entity that manages the Allowed AMIs settings. Possible values include:
    ///
    /// * `account` - The Allowed AMIs settings is managed by the account.
    ///
    /// * `declarative-policy` - The Allowed AMIs settings is managed by a
    /// declarative policy and can't be modified by the account.
    managed_by: ?ManagedBy = null,

    /// The current state of the Allowed AMIs setting at the account level in the
    /// specified Amazon Web Services
    /// Region.
    ///
    /// Possible values:
    ///
    /// * `disabled`: All AMIs are allowed.
    ///
    /// * `audit-mode`: All AMIs are allowed, but the `ImageAllowed` field
    /// is set to `true` if the AMI would be allowed with the current list of
    /// criteria
    /// if allowed AMIs was enabled.
    ///
    /// * `enabled`: Only AMIs matching the image criteria are discoverable and
    /// available for use.
    state: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAllowedImagesSettingsInput, options: CallOptions) !GetAllowedImagesSettingsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetAllowedImagesSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetAllowedImagesSettings&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAllowedImagesSettingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetAllowedImagesSettingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imageCriterionSet")) {
                    result.image_criteria = try serde.deserializeImageCriterionList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "managedBy")) {
                    result.managed_by = std.meta.stringToEnum(ManagedBy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "state")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
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
