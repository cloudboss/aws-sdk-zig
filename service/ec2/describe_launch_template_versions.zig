const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const LaunchTemplateVersion = @import("launch_template_version.zig").LaunchTemplateVersion;

/// Describes one or more versions of a specified launch template. You can
/// describe all
/// versions, individual versions, or a range of versions. You can also describe
/// all the
/// latest versions or all the default versions of all the launch templates in
/// your
/// account.
pub const DescribeLaunchTemplateVersionsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters.
    ///
    /// * `create-time` - The time the launch template version was
    /// created.
    ///
    /// * `ebs-optimized` - A boolean that indicates whether the instance is
    /// optimized for Amazon EBS I/O.
    ///
    /// * `http-endpoint` - Indicates whether the HTTP metadata endpoint on
    /// your instances is enabled (`enabled` | `disabled`).
    ///
    /// * `http-protocol-ipv4` - Indicates whether the IPv4 endpoint for the
    /// instance metadata service is enabled (`enabled` |
    /// `disabled`).
    ///
    /// * `host-resource-group-arn` - The ARN of the host resource group in
    /// which to launch the instances.
    ///
    /// * `http-tokens` - The state of token usage for your instance metadata
    /// requests (`optional` | `required`).
    ///
    /// * `iam-instance-profile` - The ARN of the IAM instance
    /// profile.
    ///
    /// * `image-id` - The ID of the AMI.
    ///
    /// * `instance-type` - The instance type.
    ///
    /// * `is-default-version` - A boolean that indicates whether the launch
    /// template version is the default version.
    ///
    /// * `kernel-id` - The kernel ID.
    ///
    /// * `license-configuration-arn` - The ARN of the license
    /// configuration.
    ///
    /// * `network-card-index` - The index of the network card.
    ///
    /// * `ram-disk-id` - The RAM disk ID.
    filters: ?[]const Filter = null,

    /// The ID of the launch template.
    ///
    /// To describe one or more versions of a specified launch template, you must
    /// specify
    /// either the launch template ID or the launch template name, but not both.
    ///
    /// To describe all the latest or default launch template versions in your
    /// account, you
    /// must omit this parameter.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    ///
    /// To describe one or more versions of a specified launch template, you must
    /// specify
    /// either the launch template name or the launch template ID, but not both.
    ///
    /// To describe all the latest or default launch template versions in your
    /// account, you
    /// must omit this parameter.
    launch_template_name: ?[]const u8 = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned `NextToken` value. This value
    /// can be between 1 and 200.
    max_results: ?i32 = null,

    /// The version number up to which to describe launch template versions.
    max_version: ?[]const u8 = null,

    /// The version number after which to describe launch template versions.
    min_version: ?[]const u8 = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// If `true`, and if a Systems Manager parameter is specified for
    /// `ImageId`, the AMI ID is displayed in the response for
    /// `imageId`.
    ///
    /// If `false`, and if a Systems Manager parameter is specified for
    /// `ImageId`, the parameter is displayed in the response for
    /// `imageId`.
    ///
    /// For more information, see [Use a Systems Manager parameter instead of an AMI
    /// ID](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#use-an-ssm-parameter-instead-of-an-ami-id) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Default: `false`
    resolve_alias: ?bool = null,

    /// One or more versions of the launch template. Valid values depend on whether
    /// you are
    /// describing a specified launch template (by ID or name) or all launch
    /// templates in your
    /// account.
    ///
    /// To describe one or more versions of a specified launch template, valid
    /// values are
    /// `$Latest`, `$Default`, and numbers.
    ///
    /// To describe all launch templates in your account that are defined as the
    /// latest
    /// version, the valid value is `$Latest`. To describe all launch templates in
    /// your account that are defined as the default version, the valid value is
    /// `$Default`. You can specify `$Latest` and
    /// `$Default` in the same request. You cannot specify numbers.
    versions: ?[]const []const u8 = null,
};

pub const DescribeLaunchTemplateVersionsOutput = struct {
    /// Information about the launch template versions.
    launch_template_versions: ?[]const LaunchTemplateVersion = null,

    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeLaunchTemplateVersionsOutput) void {
        if (self.next_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeLaunchTemplateVersionsInput, options: Options) !DescribeLaunchTemplateVersionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeLaunchTemplateVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeLaunchTemplateVersions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.launch_template_id) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_template_name) |v| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.max_version) |v| {
        try body_buf.appendSlice(alloc, "&MaxVersion=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.min_version) |v| {
        try body_buf.appendSlice(alloc, "&MinVersion=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resolve_alias) |v| {
        try body_buf.appendSlice(alloc, "&ResolveAlias=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.versions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Versions.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeLaunchTemplateVersionsOutput {
    _ = status;
    _ = headers;
    var result: DescribeLaunchTemplateVersionsOutput = .{ .allocator = alloc };
    if (findElement(body, "nextToken")) |content| {
        result.next_token = try alloc.dupe(u8, content);
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
