const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentLink = @import("environment_link.zig").EnvironmentLink;
const EnvironmentHealth = @import("environment_health.zig").EnvironmentHealth;
const EnvironmentHealthStatus = @import("environment_health_status.zig").EnvironmentHealthStatus;
const EnvironmentResourcesDescription = @import("environment_resources_description.zig").EnvironmentResourcesDescription;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const EnvironmentTier = @import("environment_tier.zig").EnvironmentTier;
const serde = @import("serde.zig");

pub const TerminateEnvironmentInput = struct {
    /// The ID of the environment to terminate.
    ///
    /// Condition: You must specify either this or an EnvironmentName, or both. If
    /// you do not specify either, Elastic Beanstalk returns
    /// `MissingRequiredParameter` error.
    environment_id: ?[]const u8 = null,

    /// The name of the environment to terminate.
    ///
    /// Condition: You must specify either this or an EnvironmentId, or both. If you
    /// do not specify either, Elastic Beanstalk returns
    /// `MissingRequiredParameter` error.
    environment_name: ?[]const u8 = null,

    /// Terminates the target environment even if another environment in the same
    /// group is dependent on it.
    force_terminate: ?bool = null,

    /// Indicates whether the associated Amazon Web Services resources should shut
    /// down when the environment is terminated:
    ///
    /// * `true`: The specified environment as well as the associated Amazon Web
    ///   Services resources, such as Auto Scaling group and LoadBalancer, are
    /// terminated.
    ///
    /// * `false`: Elastic Beanstalk resource management is removed from the
    ///   environment, but the Amazon Web Services resources continue to operate.
    ///
    /// For more information, see the [ Elastic Beanstalk User Guide.
    /// ](https://docs.aws.amazon.com/elasticbeanstalk/latest/ug/)
    ///
    /// Default: `true`
    ///
    /// Valid Values: `true` | `false`
    terminate_resources: ?bool = null,
};

pub const TerminateEnvironmentOutput = @import("environment_description.zig").EnvironmentDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateEnvironmentInput, options: CallOptions) !TerminateEnvironmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=TerminateEnvironment&Version=2010-12-01");
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.force_terminate) |v| {
        try body_buf.appendSlice(allocator, "&ForceTerminate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.terminate_resources) |v| {
        try body_buf.appendSlice(allocator, "&TerminateResources=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateEnvironmentOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TerminateEnvironmentResult")) break;
            },
            else => {},
        }
    }

    var result: TerminateEnvironmentOutput = .{};
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
