const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FastLaunchLaunchTemplateSpecificationResponse = @import("fast_launch_launch_template_specification_response.zig").FastLaunchLaunchTemplateSpecificationResponse;
const FastLaunchResourceType = @import("fast_launch_resource_type.zig").FastLaunchResourceType;
const FastLaunchSnapshotConfigurationResponse = @import("fast_launch_snapshot_configuration_response.zig").FastLaunchSnapshotConfigurationResponse;
const FastLaunchStateCode = @import("fast_launch_state_code.zig").FastLaunchStateCode;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DisableFastLaunchOutput) void {
        self._arena.deinit();
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DisableFastLaunchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DisableFastLaunch&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(alloc, "&Force=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.image_id);

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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DisableFastLaunchOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "launchTemplate")) {
                    result.launch_template = try serde.deserializeFastLaunchLaunchTemplateSpecificationResponse(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "maxParallelLaunches")) {
                    result.max_parallel_launches = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ownerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "resourceType")) {
                    result.resource_type = std.meta.stringToEnum(FastLaunchResourceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotConfiguration")) {
                    result.snapshot_configuration = try serde.deserializeFastLaunchSnapshotConfigurationResponse(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "state")) {
                    result.state = std.meta.stringToEnum(FastLaunchStateCode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "stateTransitionReason")) {
                    result.state_transition_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "stateTransitionTime")) {
                    result.state_transition_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
