const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BuildConfiguration = @import("build_configuration.zig").BuildConfiguration;
const SourceBuildInformation = @import("source_build_information.zig").SourceBuildInformation;
const S3Location = @import("s3_location.zig").S3Location;
const Tag = @import("tag.zig").Tag;
const ApplicationVersionDescription = @import("application_version_description.zig").ApplicationVersionDescription;
const serde = @import("serde.zig");

pub const CreateApplicationVersionInput = struct {
    /// The name of the application. If no application is found with this name, and
    /// `AutoCreateApplication` is `false`, returns an
    /// `InvalidParameterValue` error.
    application_name: []const u8,

    /// Set to `true` to create an application with the specified name if it doesn't
    /// already exist.
    auto_create_application: ?bool = null,

    /// Settings for an AWS CodeBuild build.
    build_configuration: ?BuildConfiguration = null,

    /// A description of this application version.
    description: ?[]const u8 = null,

    /// Pre-processes and validates the environment manifest (`env.yaml`) and
    /// configuration files (`*.config` files in the `.ebextensions` folder) in
    /// the source bundle. Validating configuration files can identify issues prior
    /// to deploying the
    /// application version to an environment.
    ///
    /// You must turn processing on for application versions that you create using
    /// AWS
    /// CodeBuild or AWS CodeCommit. For application versions built from a source
    /// bundle in Amazon S3,
    /// processing is optional.
    ///
    /// The `Process` option validates Elastic Beanstalk configuration files. It
    /// doesn't validate your application's configuration files, like proxy server
    /// or Docker
    /// configuration.
    process: ?bool = null,

    /// Specify a commit in an AWS CodeCommit Git repository to use as the source
    /// code for the
    /// application version.
    source_build_information: ?SourceBuildInformation = null,

    /// The Amazon S3 bucket and key that identify the location of the source bundle
    /// for this
    /// version.
    ///
    /// The Amazon S3 bucket must be in the same region as the
    /// environment.
    ///
    /// Specify a source bundle in S3 or a commit in an AWS CodeCommit repository
    /// (with
    /// `SourceBuildInformation`), but not both. If neither `SourceBundle` nor
    /// `SourceBuildInformation` are provided, Elastic Beanstalk uses a sample
    /// application.
    source_bundle: ?S3Location = null,

    /// Specifies the tags applied to the application version.
    ///
    /// Elastic Beanstalk applies these tags only to the application version.
    /// Environments that use the
    /// application version don't inherit the tags.
    tags: ?[]const Tag = null,

    /// A label identifying this version.
    ///
    /// Constraint: Must be unique per application. If an application version
    /// already exists
    /// with this label for the specified application, AWS Elastic Beanstalk returns
    /// an
    /// `InvalidParameterValue` error.
    version_label: []const u8,
};

pub const CreateApplicationVersionOutput = struct {
    /// The ApplicationVersionDescription of the application version.
    application_version: ?ApplicationVersionDescription = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationVersionInput, options: Options) !CreateApplicationVersionOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateApplicationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateApplicationVersion&Version=2010-12-01");
    try body_buf.appendSlice(alloc, "&ApplicationName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.application_name);
    if (input.auto_create_application) |v| {
        try body_buf.appendSlice(alloc, "&AutoCreateApplication=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.build_configuration) |v| {
        if (v.artifact_name) |sv| {
            try body_buf.appendSlice(alloc, "&BuildConfiguration.ArtifactName=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        try body_buf.appendSlice(alloc, "&BuildConfiguration.CodeBuildServiceRole=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.code_build_service_role);
        if (v.compute_type) |sv| {
            try body_buf.appendSlice(alloc, "&BuildConfiguration.ComputeType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        try body_buf.appendSlice(alloc, "&BuildConfiguration.Image=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.image);
        if (v.timeout_in_minutes) |sv| {
            try body_buf.appendSlice(alloc, "&BuildConfiguration.TimeoutInMinutes=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.process) |v| {
        try body_buf.appendSlice(alloc, "&Process=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.source_build_information) |v| {
        try body_buf.appendSlice(alloc, "&SourceBuildInformation.SourceLocation=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.source_location);
        try body_buf.appendSlice(alloc, "&SourceBuildInformation.SourceRepository=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v.source_repository));
        try body_buf.appendSlice(alloc, "&SourceBuildInformation.SourceType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v.source_type));
    }
    if (input.source_bundle) |v| {
        if (v.s3_bucket) |sv| {
            try body_buf.appendSlice(alloc, "&SourceBundle.S3Bucket=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.s3_key) |sv| {
            try body_buf.appendSlice(alloc, "&SourceBundle.S3Key=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VersionLabel=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.version_label);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateApplicationVersionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateApplicationVersionResult")) break;
            },
            else => {},
        }
    }

    var result: CreateApplicationVersionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationVersion")) {
                    result.application_version = try serde.deserializeApplicationVersionDescription(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
