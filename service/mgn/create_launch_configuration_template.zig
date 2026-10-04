const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BootMode = @import("boot_mode.zig").BootMode;
const LaunchTemplateDiskConf = @import("launch_template_disk_conf.zig").LaunchTemplateDiskConf;
const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const Licensing = @import("licensing.zig").Licensing;
const PostLaunchActions = @import("post_launch_actions.zig").PostLaunchActions;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;

pub const CreateLaunchConfigurationTemplateInput = struct {
    /// Associate public Ip address.
    associate_public_ip_address: ?bool = null,

    /// Launch configuration template boot mode.
    boot_mode: ?BootMode = null,

    /// Copy private Ip.
    copy_private_ip: ?bool = null,

    /// Copy tags.
    copy_tags: ?bool = null,

    /// Enable map auto tagging.
    enable_map_auto_tagging: ?bool = null,

    /// Enable parameters encryption.
    enable_parameters_encryption: ?bool = null,

    /// Large volume config.
    large_volume_conf: ?LaunchTemplateDiskConf = null,

    /// Launch disposition.
    launch_disposition: ?LaunchDisposition = null,

    licensing: ?Licensing = null,

    /// Launch configuration template map auto tagging MPE ID.
    map_auto_tagging_mpe_id: ?[]const u8 = null,

    /// Parameters encryption key.
    parameters_encryption_key: ?[]const u8 = null,

    /// Launch configuration template post launch actions.
    post_launch_actions: ?PostLaunchActions = null,

    /// Small volume config.
    small_volume_conf: ?LaunchTemplateDiskConf = null,

    /// Small volume maximum size.
    small_volume_max_size: ?i64 = null,

    /// Request to associate tags during creation of a Launch Configuration
    /// Template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Target instance type right-sizing method.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .associate_public_ip_address = "associatePublicIpAddress",
        .boot_mode = "bootMode",
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .enable_map_auto_tagging = "enableMapAutoTagging",
        .enable_parameters_encryption = "enableParametersEncryption",
        .large_volume_conf = "largeVolumeConf",
        .launch_disposition = "launchDisposition",
        .licensing = "licensing",
        .map_auto_tagging_mpe_id = "mapAutoTaggingMpeID",
        .parameters_encryption_key = "parametersEncryptionKey",
        .post_launch_actions = "postLaunchActions",
        .small_volume_conf = "smallVolumeConf",
        .small_volume_max_size = "smallVolumeMaxSize",
        .tags = "tags",
        .target_instance_type_right_sizing_method = "targetInstanceTypeRightSizingMethod",
    };
};

pub const CreateLaunchConfigurationTemplateOutput = @import("launch_configuration_template.zig").LaunchConfigurationTemplate;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLaunchConfigurationTemplateInput, options: CallOptions) !CreateLaunchConfigurationTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLaunchConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateLaunchConfigurationTemplate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.associate_public_ip_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"associatePublicIpAddress\":");
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
    if (input.enable_parameters_encryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableParametersEncryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.large_volume_conf) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"largeVolumeConf\":");
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
    if (input.parameters_encryption_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parametersEncryptionKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.post_launch_actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"postLaunchActions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.small_volume_conf) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"smallVolumeConf\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.small_volume_max_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"smallVolumeMaxSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLaunchConfigurationTemplateOutput {
    const result: CreateLaunchConfigurationTemplateOutput = try aws.json.parseJsonObject(
        CreateLaunchConfigurationTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
