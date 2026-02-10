const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestLaunchTemplateData = @import("request_launch_template_data.zig").RequestLaunchTemplateData;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;

/// Creates a launch template.
///
/// A launch template contains the parameters to launch an instance. When you
/// launch an
/// instance using RunInstances, you can specify a launch template instead
/// of providing the launch parameters in the request. For more information, see
/// [Store
/// instance launch parameters in Amazon EC2 launch
/// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the
/// *Amazon EC2 User Guide*.
///
/// To clone an existing launch template as the basis for a new launch template,
/// use the
/// Amazon EC2 console. The API, SDKs, and CLI do not support cloning a
/// template. For more
/// information, see [Create a launch template from an existing launch
/// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#create-launch-template-from-existing-launch-template) in the
/// *Amazon EC2 User Guide*.
pub const CreateLaunchTemplateInput = struct {
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

    /// A name for the launch template.
    launch_template_name: []const u8,

    /// Reserved for internal use.
    operator: ?OperatorRequest = null,

    /// The tags to apply to the launch template on creation. To tag the launch
    /// template, the
    /// resource type must be `launch-template`.
    ///
    /// To specify the tags for the resources that are created when an instance is
    /// launched,
    /// you must use the `TagSpecifications` parameter in the [launch template
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestLaunchTemplateData.html) structure.
    tag_specifications: ?[]const TagSpecification = null,

    /// A description for the first version of the launch template.
    version_description: ?[]const u8 = null,
};

pub const CreateLaunchTemplateOutput = struct {
    /// Information about the launch template.
    launch_template: ?LaunchTemplate = null,

    /// If the launch template contains parameters or parameter combinations that
    /// are not
    /// valid, an error code and an error message are returned for each issue that's
    /// found.
    warning: ?ValidationWarning = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateLaunchTemplateOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateLaunchTemplateInput, options: Options) !CreateLaunchTemplateOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLaunchTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateLaunchTemplate&Version=2016-11-15");
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
    try body_buf.appendSlice(alloc, "&LaunchTemplateName=");
    try appendUrlEncoded(alloc, &body_buf, input.launch_template_name);
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(alloc, "&Operator.Principal=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateLaunchTemplateOutput {
    _ = status;
    _ = body;
    const result: CreateLaunchTemplateOutput = .{ .allocator = alloc };

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
