const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const LaunchIntoInstanceProperties = @import("launch_into_instance_properties.zig").LaunchIntoInstanceProperties;
const Licensing = @import("licensing.zig").Licensing;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;

pub const GetLaunchConfigurationInput = struct {
    /// The ID of the Source Server that we want to retrieve a Launch Configuration
    /// for.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .source_server_id = "sourceServerID",
    };
};

pub const GetLaunchConfigurationOutput = struct {
    /// Whether we should copy the Private IP of the Source Server to the Recovery
    /// Instance.
    copy_private_ip: ?bool = null,

    /// Whether we want to copy the tags of the Source Server to the EC2 machine of
    /// the Recovery Instance.
    copy_tags: ?bool = null,

    /// The EC2 launch template ID of this launch configuration.
    ec_2_launch_template_id: ?[]const u8 = null,

    /// The state of the Recovery Instance in EC2 after the recovery operation.
    launch_disposition: ?LaunchDisposition = null,

    /// Launch into existing instance properties.
    launch_into_instance_properties: ?LaunchIntoInstanceProperties = null,

    /// The licensing configuration to be used for this launch configuration.
    licensing: ?Licensing = null,

    /// The name of the launch configuration.
    name: ?[]const u8 = null,

    /// Whether we want to activate post-launch actions for the Source Server.
    post_launch_enabled: ?bool = null,

    /// The ID of the Source Server for this launch configuration.
    source_server_id: ?[]const u8 = null,

    /// Whether Elastic Disaster Recovery should try to automatically choose the
    /// instance type that best matches the OS, CPU, and RAM of your Source Server.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .ec_2_launch_template_id = "ec2LaunchTemplateID",
        .launch_disposition = "launchDisposition",
        .launch_into_instance_properties = "launchIntoInstanceProperties",
        .licensing = "licensing",
        .name = "name",
        .post_launch_enabled = "postLaunchEnabled",
        .source_server_id = "sourceServerID",
        .target_instance_type_right_sizing_method = "targetInstanceTypeRightSizingMethod",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLaunchConfigurationInput, options: CallOptions) !GetLaunchConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLaunchConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetLaunchConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLaunchConfigurationOutput {
    var result: GetLaunchConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLaunchConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
