const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceMetricSelection = @import("resource_metric_selection.zig").ResourceMetricSelection;
const ResourceMetricsConfiguration = @import("resource_metrics_configuration.zig").ResourceMetricsConfiguration;
const serde = @import("serde.zig");

pub const CreateResourceMetricsConfigurationInput = struct {
    /// Specifies which metrics Amazon CloudWatch collects for the resource. If you
    /// omit
    /// this parameter, Amazon CloudWatch collects all available detailed metrics
    /// for the
    /// resource.
    metric_selections: ?[]const ResourceMetricSelection = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource to enable
    /// detailed
    /// monitoring for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .metric_selections = "MetricSelections",
        .resource_arn = "ResourceArn",
    };
};

pub const CreateResourceMetricsConfigurationOutput = struct {
    /// The resource metrics configuration that was created by this operation.
    resource_metrics_configuration: ?ResourceMetricsConfiguration = null,

    pub const json_field_names = .{
        .resource_metrics_configuration = "ResourceMetricsConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceMetricsConfigurationInput, options: CallOptions) !CreateResourceMetricsConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceMetricsConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateResourceMetricsConfiguration&Version=2010-08-01");
    if (input.metric_selections) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            for (item.include_metrics, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricSelections.member.{d}.IncludeMetrics.member.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&ResourceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceMetricsConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateResourceMetricsConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: CreateResourceMetricsConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceMetricsConfiguration")) {
                    result.resource_metrics_configuration = try serde.deserializeResourceMetricsConfiguration(allocator, &reader);
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
