const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AllowedImagesSettingsEnabledState = @import("allowed_images_settings_enabled_state.zig").AllowedImagesSettingsEnabledState;

/// Enables Allowed AMIs for your account in the specified Amazon Web Services
/// Region. Two values are
/// accepted:
///
/// * `enabled`: The image criteria in your Allowed AMIs settings are applied.
///   As
/// a result, only AMIs matching these criteria are discoverable and can be used
/// by your
/// account to launch instances.
///
/// * `audit-mode`: The image criteria in your Allowed AMIs settings are not
/// applied. No restrictions are placed on AMI discoverability or usage. Users
/// in your account
/// can launch instances using any public AMI or AMI shared with your account.
///
/// The purpose of `audit-mode` is to indicate which AMIs will be affected when
/// Allowed AMIs is `enabled`. In `audit-mode`, each AMI displays either
/// `"ImageAllowed": true` or `"ImageAllowed": false` to indicate
/// whether the AMI will be discoverable and available to users in the account
/// when Allowed
/// AMIs is enabled.
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
pub const EnableAllowedImagesSettingsInput = struct {
    /// Specify `enabled` to apply the image criteria specified by the Allowed AMIs
    /// settings. Specify `audit-mode` so that you can check which AMIs will be
    /// allowed or
    /// not allowed by the image criteria.
    allowed_images_settings_state: AllowedImagesSettingsEnabledState,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,
};

pub const EnableAllowedImagesSettingsOutput = struct {
    /// Returns `enabled` or `audit-mode` if the request succeeds;
    /// otherwise, it returns an error.
    allowed_images_settings_state: ?AllowedImagesSettingsEnabledState = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const EnableAllowedImagesSettingsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: EnableAllowedImagesSettingsInput, options: Options) !EnableAllowedImagesSettingsOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: EnableAllowedImagesSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=EnableAllowedImagesSettings&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AllowedImagesSettingsState=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.allowed_images_settings_state));
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !EnableAllowedImagesSettingsOutput {
    _ = status;
    _ = body;
    const result: EnableAllowedImagesSettingsOutput = .{ .allocator = alloc };

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
