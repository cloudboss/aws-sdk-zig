const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FastLaunchLaunchTemplateSpecificationRequest = @import("fast_launch_launch_template_specification_request.zig").FastLaunchLaunchTemplateSpecificationRequest;
const FastLaunchSnapshotConfigurationRequest = @import("fast_launch_snapshot_configuration_request.zig").FastLaunchSnapshotConfigurationRequest;
const FastLaunchLaunchTemplateSpecificationResponse = @import("fast_launch_launch_template_specification_response.zig").FastLaunchLaunchTemplateSpecificationResponse;
const FastLaunchResourceType = @import("fast_launch_resource_type.zig").FastLaunchResourceType;
const FastLaunchSnapshotConfigurationResponse = @import("fast_launch_snapshot_configuration_response.zig").FastLaunchSnapshotConfigurationResponse;
const FastLaunchStateCode = @import("fast_launch_state_code.zig").FastLaunchStateCode;
const serde = @import("serde.zig");

pub const EnableFastLaunchInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specify the ID of the image for which to enable Windows fast launch.
    image_id: []const u8,

    /// The launch template to use when launching Windows instances from
    /// pre-provisioned
    /// snapshots. Launch template parameters can include either the name or ID of
    /// the launch
    /// template, but not both.
    launch_template: ?FastLaunchLaunchTemplateSpecificationRequest = null,

    /// The maximum number of instances that Amazon EC2 can launch at the same time
    /// to create
    /// pre-provisioned snapshots for Windows fast launch. Value must be `6` or
    /// greater.
    max_parallel_launches: ?i32 = null,

    /// The type of resource to use for pre-provisioning the AMI for Windows fast
    /// launch.
    /// Supported values include: `snapshot`, which is the default value.
    resource_type: ?[]const u8 = null,

    /// Configuration settings for creating and managing the snapshots that are used
    /// for
    /// pre-provisioning the AMI for Windows fast launch. The associated
    /// `ResourceType`
    /// must be `snapshot`.
    snapshot_configuration: ?FastLaunchSnapshotConfigurationRequest = null,
};

pub const EnableFastLaunchOutput = struct {
    /// The image ID that identifies the AMI for which Windows fast launch was
    /// enabled.
    image_id: ?[]const u8 = null,

    /// The launch template that is used when launching Windows instances from
    /// pre-provisioned
    /// snapshots.
    launch_template: ?FastLaunchLaunchTemplateSpecificationResponse = null,

    /// The maximum number of instances that Amazon EC2 can launch at the same time
    /// to create
    /// pre-provisioned snapshots for Windows fast launch.
    max_parallel_launches: ?i32 = null,

    /// The owner ID for the AMI for which Windows fast launch was enabled.
    owner_id: ?[]const u8 = null,

    /// The type of resource that was defined for pre-provisioning the AMI for
    /// Windows fast
    /// launch.
    resource_type: ?FastLaunchResourceType = null,

    /// Settings to create and manage the pre-provisioned snapshots that Amazon EC2
    /// uses for faster
    /// launches from the Windows AMI. This property is returned when the associated
    /// `resourceType` is `snapshot`.
    snapshot_configuration: ?FastLaunchSnapshotConfigurationResponse = null,

    /// The current state of Windows fast launch for the specified AMI.
    state: ?FastLaunchStateCode = null,

    /// The reason that the state changed for Windows fast launch for the AMI.
    state_transition_reason: ?[]const u8 = null,

    /// The time that the state changed for Windows fast launch for the AMI.
    state_transition_time: ?i64 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *EnableFastLaunchOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: EnableFastLaunchInput, options: Options) !EnableFastLaunchOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: EnableFastLaunchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=EnableFastLaunch&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.image_id);
    if (input.launch_template) |v| {
        if (v.launch_template_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchTemplate.LaunchTemplateId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.launch_template_name) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchTemplate.LaunchTemplateName=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        try body_buf.appendSlice(alloc, "&LaunchTemplate.Version=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.version);
    }
    if (input.max_parallel_launches) |v| {
        try body_buf.appendSlice(alloc, "&MaxParallelLaunches=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.resource_type) |v| {
        try body_buf.appendSlice(alloc, "&ResourceType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.snapshot_configuration) |v| {
        if (v.target_resource_count) |sv| {
            try body_buf.appendSlice(alloc, "&SnapshotConfiguration.TargetResourceCount=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !EnableFastLaunchOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: EnableFastLaunchOutput = .{};
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
