const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EntityMetricData = @import("entity_metric_data.zig").EntityMetricData;
const MetricDatum = @import("metric_datum.zig").MetricDatum;
const serde = @import("serde.zig");

pub const PutMetricDataInput = struct {
    /// Data for metrics that contain associated entity information. You can include
    /// up to
    /// two `EntityMetricData` objects, each of which can contain a single
    /// `Entity` and associated metrics.
    ///
    /// The limit of metrics allowed, 1000, is the sum of both `EntityMetricData`
    /// and `MetricData` metrics.
    entity_metric_data: ?[]const EntityMetricData = null,

    /// The data for the metrics. Use this parameter if your metrics do not contain
    /// associated entities. The array can include no more than 1000 metrics per
    /// call.
    ///
    /// The limit of metrics allowed, 1000, is the sum of both `EntityMetricData`
    /// and `MetricData` metrics.
    metric_data: ?[]const MetricDatum = null,

    /// The namespace for the metric data. You can use ASCII characters for the
    /// namespace,
    /// except for control characters which are not supported.
    ///
    /// To avoid conflicts with Amazon Web Services service namespaces, you should
    /// not
    /// specify a namespace that begins with `AWS/`
    namespace: []const u8,

    /// Whether to accept valid metric data when an invalid entity is sent.
    ///
    /// * When set to `true`: Any validation error (for entity or metric
    /// data) will fail the entire request, and no data will be ingested. The failed
    /// operation will return a 400 result with the error.
    ///
    /// * When set to `false`: Validation errors in the entity will not
    /// associate the metric with the entity, but the metric data will still be
    /// accepted and ingested. Validation errors in the metric data will fail the
    /// entire request, and no data will be ingested.
    ///
    /// In the case of an invalid entity, the operation will return a
    /// `200` status, but an additional response header will contain
    /// information about the validation errors. The new header,
    /// `X-Amzn-Failure-Message` is an enumeration of the following
    /// values:
    ///
    /// * `InvalidEntity` - The provided entity is invalid.
    ///
    /// * `InvalidKeyAttributes` - The provided
    /// `KeyAttributes` of an entity is invalid.
    ///
    /// * `InvalidAttributes` - The provided `Attributes`
    /// of an entity is invalid.
    ///
    /// * `InvalidTypeValue` - The provided `Type` in the
    /// `KeyAttributes` of an entity is invalid.
    ///
    /// * `EntitySizeTooLarge` - The number of
    /// `EntityMetricData` objects allowed is 2.
    ///
    /// * `MissingRequiredFields` - There are missing required
    /// fields in the `KeyAttributes` for the provided
    /// `Type`.
    ///
    /// For details of the requirements for specifying an entity, see
    /// [How
    /// to add related information to
    /// telemetry](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/adding-your-own-related-telemetry.html) in the
    /// *CloudWatch User Guide*.
    ///
    /// This parameter is *required* when `EntityMetricData` is
    /// included.
    strict_entity_validation: ?bool = null,

    pub const json_field_names = .{
        .entity_metric_data = "EntityMetricData",
        .metric_data = "MetricData",
        .namespace = "Namespace",
        .strict_entity_validation = "StrictEntityValidation",
    };
};

pub const PutMetricDataOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMetricDataInput, options: Options) !PutMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: PutMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=PutMetricData&Version=2010-08-01");
    if (input.entity_metric_data) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.entity) |sv_1| {}
            if (item.metric_data) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    if (item_1.counts) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Counts.member.{d}=", .{ n, n_1, n_2 }) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                            }
                        }
                    }
                    if (item_1.dimensions) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Dimensions.member.{d}.Name=", .{ n, n_1, n_2 }) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.name);
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Dimensions.member.{d}.Value=", .{ n, n_1, n_2 }) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_2.value);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.MetricName=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1.metric_name);
                    }
                    if (item_1.statistic_values) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.StatisticValues.Maximum=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, sv_2.maximum);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.StatisticValues.Minimum=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, sv_2.minimum);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.StatisticValues.SampleCount=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, sv_2.sample_count);
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.StatisticValues.Sum=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, sv_2.sum);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.StorageResolution=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.storage_resolution) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Timestamp=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.timestamp) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Unit=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.unit) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Value=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.values) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EntityMetricData.member.{d}.MetricData.member.{d}.Values.member.{d}=", .{ n, n_1, n_2 }) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                            }
                        }
                    }
                }
            }
        }
    }
    if (input.metric_data) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.counts) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Counts.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
            if (item.dimensions) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Dimensions.member.{d}.Name=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1.name);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Dimensions.member.{d}.Value=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1.value);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.MetricName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.metric_name);
            }
            if (item.statistic_values) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.StatisticValues.Maximum=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.maximum);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.StatisticValues.Minimum=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.minimum);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.StatisticValues.SampleCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.sample_count);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.StatisticValues.Sum=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv_1.sum);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.StorageResolution=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.storage_resolution) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Timestamp=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.timestamp) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Unit=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.unit) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricData.member.{d}.Values.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&Namespace=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.namespace);
    if (input.strict_entity_validation) |v| {
        try body_buf.appendSlice(alloc, "&StrictEntityValidation=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutMetricDataOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: PutMetricDataOutput = .{};

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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardInvalidInputError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_invalid_input_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFormatFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_format_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
