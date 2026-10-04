const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const Licensing = @import("licensing.zig").Licensing;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;
const LaunchConfigurationTemplate = @import("launch_configuration_template.zig").LaunchConfigurationTemplate;

pub const CreateLaunchConfigurationTemplateInput = struct {
    /// Copy private IP.
    copy_private_ip: ?bool = null,

    /// Copy tags.
    copy_tags: ?bool = null,

    /// S3 bucket ARN to export Source Network templates.
    export_bucket_arn: ?[]const u8 = null,

    /// Launch disposition.
    launch_disposition: ?LaunchDisposition = null,

    /// DRS will set the 'launch into instance ID' of any source server when
    /// performing a drill, recovery or failback to the previous region or
    /// availability zone, using the instance ID of the source instance.
    launch_into_source_instance: ?bool = null,

    /// Licensing.
    licensing: ?Licensing = null,

    /// Whether we want to activate post-launch actions.
    post_launch_enabled: ?bool = null,

    /// Request to associate tags during creation of a Launch Configuration
    /// Template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Target instance type right-sizing method.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .export_bucket_arn = "exportBucketArn",
        .launch_disposition = "launchDisposition",
        .launch_into_source_instance = "launchIntoSourceInstance",
        .licensing = "licensing",
        .post_launch_enabled = "postLaunchEnabled",
        .tags = "tags",
        .target_instance_type_right_sizing_method = "targetInstanceTypeRightSizingMethod",
    };
};

pub const CreateLaunchConfigurationTemplateOutput = struct {
    /// Created Launch Configuration Template.
    launch_configuration_template: ?LaunchConfigurationTemplate = null,

    pub const json_field_names = .{
        .launch_configuration_template = "launchConfigurationTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLaunchConfigurationTemplateInput, options: CallOptions) !CreateLaunchConfigurationTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLaunchConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateLaunchConfigurationTemplate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.export_bucket_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exportBucketArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_disposition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"launchDisposition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_into_source_instance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"launchIntoSourceInstance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.licensing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"licensing\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.post_launch_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"postLaunchEnabled\":");
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
    var result: CreateLaunchConfigurationTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLaunchConfigurationTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
