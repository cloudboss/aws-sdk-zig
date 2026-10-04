const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationVersionInput, options: CallOptions) !CreateApplicationVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateApplicationVersion&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.auto_create_application) |v| {
        try body_buf.appendSlice(allocator, "&AutoCreateApplication=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.build_configuration) |v| {
        if (v.artifact_name) |sv| {
            try body_buf.appendSlice(allocator, "&BuildConfiguration.ArtifactName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        try body_buf.appendSlice(allocator, "&BuildConfiguration.CodeBuildServiceRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.code_build_service_role);
        if (v.compute_type) |sv| {
            try body_buf.appendSlice(allocator, "&BuildConfiguration.ComputeType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        try body_buf.appendSlice(allocator, "&BuildConfiguration.Image=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.image);
        if (v.timeout_in_minutes) |sv| {
            try body_buf.appendSlice(allocator, "&BuildConfiguration.TimeoutInMinutes=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.process) |v| {
        try body_buf.appendSlice(allocator, "&Process=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.source_build_information) |v| {
        try body_buf.appendSlice(allocator, "&SourceBuildInformation.SourceLocation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.source_location);
        try body_buf.appendSlice(allocator, "&SourceBuildInformation.SourceRepository=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.source_repository.wireName());
        try body_buf.appendSlice(allocator, "&SourceBuildInformation.SourceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.source_type.wireName());
    }
    if (input.source_bundle) |v| {
        if (v.s3_bucket) |sv| {
            try body_buf.appendSlice(allocator, "&SourceBundle.S3Bucket=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.s3_key) |sv| {
            try body_buf.appendSlice(allocator, "&SourceBundle.S3Key=");
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
    try body_buf.appendSlice(allocator, "&VersionLabel=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.version_label);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationVersionOutput {
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
                    result.application_version = try serde.deserializeApplicationVersionDescription(allocator, &reader);
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
