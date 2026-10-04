const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BootMode = @import("boot_mode.zig").BootMode;
const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const Licensing = @import("licensing.zig").Licensing;
const PostLaunchActions = @import("post_launch_actions.zig").PostLaunchActions;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;

pub const GetLaunchConfigurationInput = struct {
    /// Request to get Launch Configuration information by Account ID.
    account_id: ?[]const u8 = null,

    /// Request to get Launch Configuration information by Source Server ID.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountID",
        .source_server_id = "sourceServerID",
    };
};

pub const GetLaunchConfigurationOutput = struct {
    /// Launch configuration boot mode.
    boot_mode: ?BootMode = null,

    /// Copy Private IP during Launch Configuration.
    copy_private_ip: ?bool = null,

    /// Copy Tags during Launch Configuration.
    copy_tags: ?bool = null,

    /// Launch configuration EC2 Launch template ID.
    ec_2_launch_template_id: ?[]const u8 = null,

    /// Enable map auto tagging.
    enable_map_auto_tagging: ?bool = null,

    /// Launch disposition for launch configuration.
    launch_disposition: ?LaunchDisposition = null,

    /// Launch configuration OS licensing.
    licensing: ?Licensing = null,

    /// Map auto tagging MPE ID.
    map_auto_tagging_mpe_id: ?[]const u8 = null,

    /// Launch configuration name.
    name: ?[]const u8 = null,

    post_launch_actions: ?PostLaunchActions = null,

    /// Launch configuration Source Server ID.
    source_server_id: ?[]const u8 = null,

    /// Launch configuration Target instance type right sizing method.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .boot_mode = "bootMode",
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .ec_2_launch_template_id = "ec2LaunchTemplateID",
        .enable_map_auto_tagging = "enableMapAutoTagging",
        .launch_disposition = "launchDisposition",
        .licensing = "licensing",
        .map_auto_tagging_mpe_id = "mapAutoTaggingMpeID",
        .name = "name",
        .post_launch_actions = "postLaunchActions",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgn", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetLaunchConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    const result: GetLaunchConfigurationOutput = try aws.json.parseJsonObject(
        GetLaunchConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
