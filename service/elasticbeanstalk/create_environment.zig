const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const OptionSpecification = @import("option_specification.zig").OptionSpecification;
const Tag = @import("tag.zig").Tag;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;
const EnvironmentLink = @import("environment_link.zig").EnvironmentLink;
const EnvironmentHealth = @import("environment_health.zig").EnvironmentHealth;
const EnvironmentHealthStatus = @import("environment_health_status.zig").EnvironmentHealthStatus;
const EnvironmentResourcesDescription = @import("environment_resources_description.zig").EnvironmentResourcesDescription;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const serde = @import("serde.zig");

pub const CreateEnvironmentInput = struct {
    /// The name of the application that is associated with this environment.
    application_name: []const u8,

    /// If specified, the environment attempts to use this value as the prefix for
    /// the CNAME in your Elastic Beanstalk environment URL. If not specified, the
    /// CNAME is
    /// generated automatically by appending a random alphanumeric string to the
    /// environment name.
    cname_prefix: ?[]const u8 = null,

    /// Your description for this environment.
    description: ?[]const u8 = null,

    /// A unique name for the environment.
    ///
    /// Constraint: Must be from 4 to 40 characters in length. The name can contain
    /// only letters, numbers, and hyphens. It can't start or end with a hyphen.
    /// This name must be unique within a region in your account. If the specified
    /// name already exists in the region, Elastic Beanstalk returns an
    /// `InvalidParameterValue` error.
    ///
    /// If you don't specify the `CNAMEPrefix` parameter, the environment name
    /// becomes part of the CNAME, and therefore part of the visible URL for
    /// your application.
    environment_name: ?[]const u8 = null,

    /// The name of the group to which the target environment belongs. Specify a
    /// group name only if the environment's name is specified in an environment
    /// manifest and not with the environment name parameter. See [Environment
    /// Manifest
    /// (env.yaml)](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environment-cfg-manifest.html) for details.
    group_name: ?[]const u8 = null,

    /// The operations role feature of Elastic Beanstalk is in beta release and is
    /// subject to change.
    ///
    /// The Amazon Resource Name (ARN) of an existing IAM role to be used as the
    /// environment's operations role. If specified, Elastic Beanstalk uses the
    /// operations role
    /// for permissions to downstream services during this call and during
    /// subsequent calls acting on this environment. To specify an operations role,
    /// you must
    /// have the `iam:PassRole` permission for the role.
    operations_role: ?[]const u8 = null,

    /// If specified, Elastic Beanstalk sets the specified configuration options to
    /// the requested value in the configuration set for the new environment. These
    /// override the values obtained from the solution stack or the configuration
    /// template.
    option_settings: ?[]const ConfigurationOptionSetting = null,

    /// A list of custom user-defined configuration options to remove from the
    /// configuration set for this new environment.
    options_to_remove: ?[]const OptionSpecification = null,

    /// The Amazon Resource Name (ARN) of the custom platform to use with the
    /// environment. For more information, see [Custom
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html) in the *Elastic Beanstalk Developer Guide*.
    ///
    /// If you specify `PlatformArn`, don't specify `SolutionStackName`.
    platform_arn: ?[]const u8 = null,

    /// The name of an Elastic Beanstalk solution stack (platform version) to use
    /// with the environment. If specified, Elastic Beanstalk sets the configuration
    /// values to the default
    /// values associated with the specified solution stack. For a list of current
    /// solution stacks, see [Elastic Beanstalk Supported
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html) in the *Elastic Beanstalk
    /// Platforms* guide.
    ///
    /// If you specify `SolutionStackName`, don't specify `PlatformArn` or
    /// `TemplateName`.
    solution_stack_name: ?[]const u8 = null,

    /// Specifies the tags applied to resources in the environment.
    tags: ?[]const Tag = null,

    /// The name of the Elastic Beanstalk configuration template to use with the
    /// environment.
    ///
    /// If you specify `TemplateName`, then don't specify `SolutionStackName`.
    template_name: ?[]const u8 = null,

    /// Specifies the tier to use in creating this environment. The environment tier
    /// that you choose determines whether Elastic Beanstalk provisions resources on
    /// Amazon EC2 instances or on an Amazon EKS cluster, and, for Amazon EC2,
    /// whether the environment serves HTTP(S) requests or processes background
    /// tasks
    /// from a queue.
    tier: ?EnvironmentTier = null,

    /// The name of the application version to deploy.
    ///
    /// Default: If not specified, Elastic Beanstalk attempts to deploy the sample
    /// application.
    version_label: ?[]const u8 = null,
};

pub const CreateEnvironmentOutput = @import("environment_description.zig").EnvironmentDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticbeanstalk", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateEnvironment&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.cname_prefix) |v| {
        try body_buf.appendSlice(allocator, "&CNAMEPrefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(allocator, "&GroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.operations_role) |v| {
        try body_buf.appendSlice(allocator, "&OperationsRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_settings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.namespace) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.option_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.OptionName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.ResourceName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.options_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.namespace) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToRemove.member.{d}.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.option_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToRemove.member.{d}.OptionName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToRemove.member.{d}.ResourceName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.platform_arn) |v| {
        try body_buf.appendSlice(allocator, "&PlatformArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.solution_stack_name) |v| {
        try body_buf.appendSlice(allocator, "&SolutionStackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.template_name) |v| {
        try body_buf.appendSlice(allocator, "&TemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tier) |v| {
        if (v.name) |sv| {
            try body_buf.appendSlice(allocator, "&Tier.Name=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.type) |sv| {
            try body_buf.appendSlice(allocator, "&Tier.Type=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.version) |sv| {
            try body_buf.appendSlice(allocator, "&Tier.Version=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.version_label) |v| {
        try body_buf.appendSlice(allocator, "&VersionLabel=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateEnvironmentResult")) break;
            },
            else => {},
        }
    }

    var result: CreateEnvironmentOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AbortableOperationInProgress")) {
                    result.abortable_operation_in_progress = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CNAME")) {
                    result.cname = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndpointURL")) {
                    result.endpoint_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentArn")) {
                    result.environment_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentId")) {
                    result.environment_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentLinks")) {
                    result.environment_links = try serde.deserializeEnvironmentLinks(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Health")) {
                    result.health = EnvironmentHealth.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = EnvironmentHealthStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationsRole")) {
                    result.operations_role = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try serde.deserializeEnvironmentResourcesDescription(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = EnvironmentStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tier")) {
                    result.tier = try serde.deserializeEnvironmentTier(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "VersionLabel")) {
                    result.version_label = try allocator.dupe(u8, try reader.readElementText());
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
