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

pub const UpdateLaunchConfigurationInput = struct {
    /// Update Launch configuration Account ID.
    account_id: ?[]const u8 = null,

    /// Update Launch configuration boot mode request.
    boot_mode: ?BootMode = null,

    /// Update Launch configuration copy Private IP request.
    copy_private_ip: ?bool = null,

    /// Update Launch configuration copy Tags request.
    copy_tags: ?bool = null,

    /// Enable map auto tagging.
    enable_map_auto_tagging: ?bool = null,

    /// Update Launch configuration launch disposition request.
    launch_disposition: ?LaunchDisposition = null,

    /// Update Launch configuration licensing request.
    licensing: ?Licensing = null,

    /// Launch configuration map auto tagging MPE ID.
    map_auto_tagging_mpe_id: ?[]const u8 = null,

    /// Update Launch configuration name request.
    name: ?[]const u8 = null,

    post_launch_actions: ?PostLaunchActions = null,

    /// Update Launch configuration by Source Server ID request.
    source_server_id: []const u8,

    /// Update Launch configuration Target instance right sizing request.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .account_id = "accountID",
        .boot_mode = "bootMode",
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
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

pub const UpdateLaunchConfigurationOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLaunchConfigurationInput, options: CallOptions) !UpdateLaunchConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLaunchConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateLaunchConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.boot_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bootMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.copy_private_ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"copyPrivateIp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.copy_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"copyTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_map_auto_tagging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableMapAutoTagging\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_disposition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"launchDisposition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.licensing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"licensing\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.map_auto_tagging_mpe_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mapAutoTaggingMpeID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.post_launch_actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"postLaunchActions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;
    if (input.target_instance_type_right_sizing_method) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetInstanceTypeRightSizingMethod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLaunchConfigurationOutput {
    const result: UpdateLaunchConfigurationOutput = try aws.json.parseJsonObject(
        UpdateLaunchConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
