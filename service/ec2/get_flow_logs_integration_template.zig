const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IntegrateServices = @import("integrate_services.zig").IntegrateServices;
const serde = @import("serde.zig");

/// Generates a CloudFormation template that streamlines and automates the
/// integration of VPC flow logs
/// with Amazon Athena. This make it easier for you to query and gain insights
/// from VPC flow logs data.
/// Based on the information that you provide, we configure resources in the
/// template to do the following:
///
/// * Create a table in Athena that maps fields to a custom log format
///
/// * Create a Lambda function that updates the table with new partitions on a
///   daily, weekly, or
/// monthly basis
///
/// * Create a table partitioned between two timestamps in the past
///
/// * Create a set of named queries in Athena that you can use to get started
///   quickly
///
/// **Note:**
///
/// `GetFlowLogsIntegrationTemplate` does not support integration between
/// Amazon Web Services Transit Gateway Flow Logs and Amazon Athena.
pub const GetFlowLogsIntegrationTemplateInput = struct {
    /// To store the CloudFormation template in Amazon S3, specify the location in
    /// Amazon S3.
    config_delivery_s_3_destination_arn: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the flow log.
    flow_log_id: []const u8,

    /// Information about the service integration.
    integrate_services: IntegrateServices,
};

pub const GetFlowLogsIntegrationTemplateOutput = struct {
    /// The generated CloudFormation template.
    result: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetFlowLogsIntegrationTemplateOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetFlowLogsIntegrationTemplateInput, options: Options) !GetFlowLogsIntegrationTemplateOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetFlowLogsIntegrationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetFlowLogsIntegrationTemplate&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&ConfigDeliveryS3DestinationArn=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.config_delivery_s_3_destination_arn);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&FlowLogId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.flow_log_id);
    if (input.integrate_services.athena_integrations) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IntegrateServices.AthenaIntegrations.item.{d}.IntegrationResultS3DestinationArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.integration_result_s_3_destination_arn);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IntegrateServices.AthenaIntegrations.item.{d}.PartitionEndDate=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.partition_end_date) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IntegrateServices.AthenaIntegrations.item.{d}.PartitionLoadFrequency=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(item.partition_load_frequency));
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IntegrateServices.AthenaIntegrations.item.{d}.PartitionStartDate=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.partition_start_date) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetFlowLogsIntegrationTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetFlowLogsIntegrationTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "result")) {
                    result.result = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
