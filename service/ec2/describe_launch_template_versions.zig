const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const LaunchTemplateVersion = @import("launch_template_version.zig").LaunchTemplateVersion;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLaunchTemplateVersionsInput, options: CallOptions) !DescribeLaunchTemplateVersionsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLaunchTemplateVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeLaunchTemplateVersions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.launch_template_id) |v| {
        try body_buf.appendSlice(allocator, "&LaunchTemplateId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.launch_template_name) |v| {
        try body_buf.appendSlice(allocator, "&LaunchTemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_version) |v| {
        try body_buf.appendSlice(allocator, "&MaxVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.min_version) |v| {
        try body_buf.appendSlice(allocator, "&MinVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.resolve_alias) |v| {
        try body_buf.appendSlice(allocator, "&ResolveAlias=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.versions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateVersion.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLaunchTemplateVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeLaunchTemplateVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "launchTemplateVersionSet")) {
                    result.launch_template_versions = try serde.deserializeLaunchTemplateVersionSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
