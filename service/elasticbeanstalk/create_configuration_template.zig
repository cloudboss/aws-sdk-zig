const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const Tag = @import("tag.zig").Tag;
const ConfigurationDeploymentStatus = @import("configuration_deployment_status.zig").ConfigurationDeploymentStatus;
const serde = @import("serde.zig");

pub const CreateConfigurationTemplateInput = struct {
    /// The name of the Elastic Beanstalk application to associate with this
    /// configuration
    /// template.
    application_name: []const u8,

    /// An optional description for this configuration.
    description: ?[]const u8 = null,

    /// The ID of an environment whose settings you want to use to create the
    /// configuration
    /// template. You must specify `EnvironmentId` if you don't specify
    /// `PlatformArn`, `SolutionStackName`, or
    /// `SourceConfiguration`.
    environment_id: ?[]const u8 = null,

    /// Option values for the Elastic Beanstalk configuration, such as the instance
    /// type. If specified, these
    /// values override the values obtained from the solution stack or the source
    /// configuration
    /// template. For a complete list of Elastic Beanstalk configuration options,
    /// see [Option
    /// Values](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    option_settings: ?[]const ConfigurationOptionSetting = null,

    /// The Amazon Resource Name (ARN) of the custom platform. For more information,
    /// see [ Custom
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html) in the *AWS Elastic Beanstalk Developer Guide*.
    ///
    /// If you specify `PlatformArn`, then don't specify
    /// `SolutionStackName`.
    platform_arn: ?[]const u8 = null,

    /// The name of an Elastic Beanstalk solution stack (platform version) that this
    /// configuration uses. For
    /// example, `64bit Amazon Linux 2013.09 running Tomcat 7 Java 7`. A solution
    /// stack
    /// specifies the operating system, runtime, and application server for a
    /// configuration template.
    /// It also determines the set of configuration options as well as the possible
    /// and default
    /// values. For more information, see [Supported
    /// Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    ///
    /// You must specify `SolutionStackName` if you don't specify
    /// `PlatformArn`, `EnvironmentId`, or
    /// `SourceConfiguration`.
    ///
    /// Use the [
    /// `ListAvailableSolutionStacks`
    /// ](https://docs.aws.amazon.com/elasticbeanstalk/latest/api/API_ListAvailableSolutionStacks.html) API to obtain a list of available
    /// solution stacks.
    solution_stack_name: ?[]const u8 = null,

    /// An Elastic Beanstalk configuration template to base this one on. If
    /// specified, Elastic Beanstalk uses the configuration values from the
    /// specified
    /// configuration template to create a new configuration.
    ///
    /// Values specified in `OptionSettings` override any values obtained from the
    /// `SourceConfiguration`.
    ///
    /// You must specify `SourceConfiguration` if you don't specify
    /// `PlatformArn`, `EnvironmentId`, or
    /// `SolutionStackName`.
    ///
    /// Constraint: If both solution stack name and source configuration are
    /// specified, the
    /// solution stack of the source configuration template must match the specified
    /// solution stack
    /// name.
    source_configuration: ?SourceConfiguration = null,

    /// Specifies the tags applied to the configuration template.
    tags: ?[]const Tag = null,

    /// The name of the configuration template.
    ///
    /// Constraint: This name must be unique per application.
    template_name: []const u8,
};

pub const CreateConfigurationTemplateOutput = @import("configuration_settings_description.zig").ConfigurationSettingsDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationTemplateInput, options: CallOptions) !CreateConfigurationTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticbeanstalk");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateConfigurationTemplate&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
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
    if (input.platform_arn) |v| {
        try body_buf.appendSlice(allocator, "&PlatformArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.solution_stack_name) |v| {
        try body_buf.appendSlice(allocator, "&SolutionStackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_configuration) |v| {
        if (v.application_name) |sv| {
            try body_buf.appendSlice(allocator, "&SourceConfiguration.ApplicationName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.template_name) |sv| {
            try body_buf.appendSlice(allocator, "&SourceConfiguration.TemplateName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
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
    try body_buf.appendSlice(allocator, "&TemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.template_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateConfigurationTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: CreateConfigurationTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DateCreated")) {
                    result.date_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DateUpdated")) {
                    result.date_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentStatus")) {
                    result.deployment_status = ConfigurationDeploymentStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OptionSettings")) {
                    result.option_settings = try serde.deserializeConfigurationOptionSettingsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try allocator.dupe(u8, try reader.readElementText());
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
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "CodeBuildNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .code_build_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ElasticBeanstalkServiceException")) {
        return .{ .arena = arena, .kind = .{ .elastic_beanstalk_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientPrivilegesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_privileges_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManagedActionInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .managed_action_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformVersionStillReferencedException")) {
        return .{ .arena = arena, .kind = .{ .platform_version_still_referenced_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3LocationNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .s3_location_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3SubscriptionRequiredException")) {
        return .{ .arena = arena, .kind = .{ .s3_subscription_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceBundleDeletionException")) {
        return .{ .arena = arena, .kind = .{ .source_bundle_deletion_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationVersionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_application_versions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_applications_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyBucketsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_buckets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyConfigurationTemplatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_configuration_templates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEnvironmentsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_environments_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPlatformsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_platforms_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
