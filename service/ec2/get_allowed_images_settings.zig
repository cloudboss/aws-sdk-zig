const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImageCriterion = @import("image_criterion.zig").ImageCriterion;
const ManagedBy = @import("managed_by.zig").ManagedBy;

/// Gets the current state of the Allowed AMIs setting and the list of Allowed
/// AMIs criteria
/// at the account level in the specified Region.
///
/// **Note:**
///
/// The Allowed AMIs feature does not restrict the AMIs owned by your account.
/// Regardless of
/// the criteria you set, the AMIs created by your account will always be
/// discoverable and
/// usable by users in your account.
///
/// For more information, see [Control the discovery and use of AMIs in
/// Amazon EC2 with Allowed
/// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
/// *Amazon EC2 User Guide*.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetAllowedImagesSettingsOutput) void {
        if (self.state) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetAllowedImagesSettingsInput, options: Options) !GetAllowedImagesSettingsOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetAllowedImagesSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetAllowedImagesSettings&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAllowedImagesSettingsOutput {
    _ = status;
    _ = headers;
    var result: GetAllowedImagesSettingsOutput = .{ .allocator = alloc };
    if (findElement(body, "state")) |content| {
        result.state = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
