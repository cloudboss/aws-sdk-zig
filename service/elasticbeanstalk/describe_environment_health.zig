const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentHealthAttribute = @import("environment_health_attribute.zig").EnvironmentHealthAttribute;
const ApplicationMetrics = @import("application_metrics.zig").ApplicationMetrics;
const InstanceHealthSummary = @import("instance_health_summary.zig").InstanceHealthSummary;
const EnvironmentHealth = @import("environment_health.zig").EnvironmentHealth;
const serde = @import("serde.zig");

pub const DescribeEnvironmentHealthInput = struct {
    /// Specify the response elements to return. To retrieve all attributes, set to
    /// `All`. If no attribute names are specified, returns the name of
    /// the environment.
    attribute_names: ?[]const EnvironmentHealthAttribute = null,

    /// Specify the environment by ID.
    ///
    /// You must specify either this or an EnvironmentName, or both.
    environment_id: ?[]const u8 = null,

    /// Specify the environment by name.
    ///
    /// You must specify either this or an EnvironmentName, or both.
    environment_name: ?[]const u8 = null,
};

pub const DescribeEnvironmentHealthOutput = struct {
    /// Application request metrics for the environment.
    application_metrics: ?ApplicationMetrics = null,

    /// Descriptions of the data that contributed to the environment's current
    /// health status.
    causes: ?[]const []const u8 = null,

    /// The [health
    /// color](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html) of the environment.
    color: ?[]const u8 = null,

    /// The environment's name.
    environment_name: ?[]const u8 = null,

    /// The [health
    /// status](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html) of the environment. For example,
    /// `Ok`.
    health_status: ?[]const u8 = null,

    /// Summary health information for the instances in the environment.
    instances_health: ?InstanceHealthSummary = null,

    /// The date and time that the health information was retrieved.
    refreshed_at: ?i64 = null,

    /// The environment's operational status. `Ready`, `Launching`, `Updating`,
    /// `Terminating`, or
    /// `Terminated`.
    status: ?EnvironmentHealth = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentHealthInput, options: CallOptions) !DescribeEnvironmentHealthOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEnvironmentHealth&Version=2010-12-01");
    if (input.attribute_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AttributeNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentHealthOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEnvironmentHealthResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEnvironmentHealthOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationMetrics")) {
                    result.application_metrics = try serde.deserializeApplicationMetrics(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Causes")) {
                    result.causes = try serde.deserializeCauses(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Color")) {
                    result.color = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnvironmentName")) {
                    result.environment_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HealthStatus")) {
                    result.health_status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstancesHealth")) {
                    result.instances_health = try serde.deserializeInstanceHealthSummary(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "RefreshedAt")) {
                    result.refreshed_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = EnvironmentHealth.fromWireName(try reader.readElementText());
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
