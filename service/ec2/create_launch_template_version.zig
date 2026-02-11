const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestLaunchTemplateData = @import("request_launch_template_data.zig").RequestLaunchTemplateData;
const LaunchTemplateVersion = @import("launch_template_version.zig").LaunchTemplateVersion;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;

/// Creates a new version of a launch template. You must specify an existing
/// launch
/// template, either by name or ID. You can determine whether the new version
/// inherits
/// parameters from a source version, and add or overwrite parameters as needed.
///
/// Launch template versions are numbered in the order in which they are
/// created. You
/// can't specify, change, or replace the numbering of launch template versions.
///
/// Launch templates are immutable; after you create a launch template, you
/// can't modify
/// it. Instead, you can create a new version of the launch template that
/// includes the
/// changes that you require.
///
/// For more information, see [Modify a launch
/// template (manage launch template
/// versions)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-launch-template-versions.html) in the
/// *Amazon EC2 User Guide*.
pub const CreateLaunchTemplateVersionInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the
    /// request. If a client token isn't specified, a randomly generated token is
    /// used in the
    /// request to ensure idempotency.
    ///
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    ///
    /// Constraint: Maximum 128 ASCII characters.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The information for the launch template.
    launch_template_data: RequestLaunchTemplateData,

    /// The ID of the launch template.
    ///
    /// You must specify either the launch template ID or the launch template name,
    /// but not
    /// both.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    ///
    /// You must specify either the launch template ID or the launch template name,
    /// but not
    /// both.
    launch_template_name: ?[]const u8 = null,

    /// If `true`, and if a Systems Manager parameter is specified for
    /// `ImageId`, the AMI ID is displayed in the response for
    /// `imageID`. For more information, see [Use a Systems Manager parameter
    /// instead of an AMI
    /// ID](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Default: `false`
    resolve_alias: ?bool = null,

    /// The version of the launch template on which to base the new version.
    /// Snapshots applied
    /// to the block device mapping are ignored when creating a new version unless
    /// they are
    /// explicitly included.
    ///
    /// If you specify this parameter, the new version inherits the launch
    /// parameters from the
    /// source version. If you specify additional launch parameters for the new
    /// version, they
    /// overwrite any corresponding launch parameters inherited from the source
    /// version.
    ///
    /// If you omit this parameter, the new version contains only the launch
    /// parameters that
    /// you specify for the new version.
    source_version: ?[]const u8 = null,

    /// A description for the version of the launch template.
    version_description: ?[]const u8 = null,
};

pub const CreateLaunchTemplateVersionOutput = struct {
    /// Information about the launch template version.
    launch_template_version: ?LaunchTemplateVersion = null,

    /// If the new version of the launch template contains parameters or parameter
    /// combinations that are not valid, an error code and an error message are
    /// returned for
    /// each issue that's found.
    warning: ?ValidationWarning = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateLaunchTemplateVersionOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateLaunchTemplateVersionInput, options: Options) !CreateLaunchTemplateVersionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLaunchTemplateVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateLaunchTemplateVersion&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_template_data.disable_api_stop) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.DisableApiStop=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.disable_api_termination) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.DisableApiTermination=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.ebs_optimized) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.EbsOptimized=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.image_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.ImageId=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.instance_initiated_shutdown_behavior) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceInitiatedShutdownBehavior=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.launch_template_data.instance_type) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.launch_template_data.kernel_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.KernelId=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.key_name) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.KeyName=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.ram_disk_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.RamDiskId=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.user_data) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.UserData=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_id) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_template_name) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resolve_alias) |v| {
        try body_buf.appendSlice(alloc, "&ResolveAlias=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.source_version) |v| {
        try body_buf.appendSlice(alloc, "&SourceVersion=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.version_description) |v| {
        try body_buf.appendSlice(alloc, "&VersionDescription=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLaunchTemplateVersionOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateLaunchTemplateVersionOutput = .{ .allocator = alloc };

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
