const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FastLaunchLaunchTemplateSpecificationResponse = @import("fast_launch_launch_template_specification_response.zig").FastLaunchLaunchTemplateSpecificationResponse;
const FastLaunchResourceType = @import("fast_launch_resource_type.zig").FastLaunchResourceType;
const FastLaunchSnapshotConfigurationResponse = @import("fast_launch_snapshot_configuration_response.zig").FastLaunchSnapshotConfigurationResponse;
const FastLaunchStateCode = @import("fast_launch_state_code.zig").FastLaunchStateCode;

/// Discontinue Windows fast launch for a Windows AMI, and clean up existing
/// pre-provisioned
/// snapshots. After you disable Windows fast launch, the AMI uses the standard
/// launch process for
/// each new instance. Amazon EC2 must remove all pre-provisioned snapshots
/// before you can enable
/// Windows fast launch again.
///
/// **Note:**
///
/// You can only change these settings for Windows AMIs that you own or that
/// have been
/// shared with you.
pub const DisableFastLaunchInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Forces the image settings to turn off Windows fast launch for your Windows
    /// AMI. This
    /// parameter overrides any errors that are encountered while cleaning up
    /// resources in your
    /// account.
    force: ?bool = null,

    /// Specify the ID of the image for which to disable Windows fast launch.
    image_id: []const u8,
};

pub const DisableFastLaunchOutput = struct {
    /// The ID of the image for which Windows fast launch was disabled.
    image_id: ?[]const u8 = null,

    /// The launch template that was used to launch Windows instances from
    /// pre-provisioned
    /// snapshots.
    launch_template: ?FastLaunchLaunchTemplateSpecificationResponse = null,

    /// The maximum number of instances that Amazon EC2 can launch at the same time
    /// to create
    /// pre-provisioned snapshots for Windows fast launch.
    max_parallel_launches: ?i32 = null,

    /// The owner of the Windows AMI for which Windows fast launch was disabled.
    owner_id: ?[]const u8 = null,

    /// The pre-provisioning resource type that must be cleaned after turning off
    /// Windows fast
    /// launch for the Windows AMI. Supported values include: `snapshot`.
    resource_type: ?FastLaunchResourceType = null,

    /// Parameters that were used for Windows fast launch for the Windows AMI before
    /// Windows fast
    /// launch was disabled. This informs the clean-up process.
    snapshot_configuration: ?FastLaunchSnapshotConfigurationResponse = null,

    /// The current state of Windows fast launch for the specified Windows AMI.
    state: ?FastLaunchStateCode = null,

    /// The reason that the state changed for Windows fast launch for the Windows
    /// AMI.
    state_transition_reason: ?[]const u8 = null,

    /// The time that the state changed for Windows fast launch for the Windows AMI.
    state_transition_time: ?i64 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DisableFastLaunchOutput) void {
        if (self.image_id) |v| {
            self.allocator.free(v);
        }
        if (self.owner_id) |v| {
            self.allocator.free(v);
        }
        if (self.state_transition_reason) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DisableFastLaunchInput, options: Options) !DisableFastLaunchOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DisableFastLaunchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DisableFastLaunch&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(alloc, "&Force=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try appendUrlEncoded(alloc, &body_buf, input.image_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DisableFastLaunchOutput {
    _ = status;
    _ = headers;
    var result: DisableFastLaunchOutput = .{ .allocator = alloc };
    if (findElement(body, "imageId")) |content| {
        result.image_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "maxParallelLaunches")) |content| {
        result.max_parallel_launches = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "ownerId")) |content| {
        result.owner_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "stateTransitionReason")) |content| {
        result.state_transition_reason = try alloc.dupe(u8, content);
    }
    if (findElement(body, "stateTransitionTime")) |content| {
        result.state_transition_time = std.fmt.parseInt(i64, content, 10) catch null;
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
