const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TargetConfigurationRequest = @import("target_configuration_request.zig").TargetConfigurationRequest;
const ReservationValue = @import("reservation_value.zig").ReservationValue;
const ReservedInstanceReservationValue = @import("reserved_instance_reservation_value.zig").ReservedInstanceReservationValue;
const TargetReservationValue = @import("target_reservation_value.zig").TargetReservationValue;
const serde = @import("serde.zig");

/// Returns a quote and exchange information for exchanging one or more
/// specified Convertible
/// Reserved Instances for a new Convertible Reserved Instance. If the exchange
/// cannot be
/// performed, the reason is returned in the response. Use
/// AcceptReservedInstancesExchangeQuote to perform the exchange.
pub const GetReservedInstancesExchangeQuoteInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making
    /// the request, and provides an error response. If you have the required
    /// permissions, the error
    /// response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of the Convertible Reserved Instances to exchange.
    reserved_instance_ids: []const []const u8,

    /// The configuration of the target Convertible Reserved Instance to exchange
    /// for your current
    /// Convertible Reserved Instances.
    target_configurations: ?[]const TargetConfigurationRequest = null,
};

pub const GetReservedInstancesExchangeQuoteOutput = struct {
    /// The currency of the transaction.
    currency_code: ?[]const u8 = null,

    /// If `true`, the exchange is valid. If `false`, the exchange cannot be
    /// completed.
    is_valid_exchange: ?bool = null,

    /// The new end date of the reservation term.
    output_reserved_instances_will_expire_at: ?i64 = null,

    /// The total true upfront charge for the exchange.
    payment_due: ?[]const u8 = null,

    /// The cost associated with the Reserved Instance.
    reserved_instance_value_rollup: ?ReservationValue = null,

    /// The configuration of your Convertible Reserved Instances.
    reserved_instance_value_set: ?[]const ReservedInstanceReservationValue = null,

    /// The cost associated with the Reserved Instance.
    target_configuration_value_rollup: ?ReservationValue = null,

    /// The values of the target Convertible Reserved Instances.
    target_configuration_value_set: ?[]const TargetReservationValue = null,

    /// Describes the reason why the exchange cannot be completed.
    validation_failure_reason: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetReservedInstancesExchangeQuoteOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetReservedInstancesExchangeQuoteInput, options: Options) !GetReservedInstancesExchangeQuoteOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetReservedInstancesExchangeQuoteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetReservedInstancesExchangeQuote&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.reserved_instance_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReservedInstanceIds.ReservedInstanceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.target_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.TargetConfigurationRequest.{d}.InstanceCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.instance_count) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TargetConfigurations.TargetConfigurationRequest.{d}.OfferingId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, item.offering_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetReservedInstancesExchangeQuoteOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetReservedInstancesExchangeQuoteOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "currencyCode")) {
                    result.currency_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "isValidExchange")) {
                    result.is_valid_exchange = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "outputReservedInstancesWillExpireAt")) {
                    result.output_reserved_instances_will_expire_at = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "paymentDue")) {
                    result.payment_due = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "reservedInstanceValueRollup")) {
                    result.reserved_instance_value_rollup = try serde.deserializeReservationValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "reservedInstanceValueSet")) {
                    result.reserved_instance_value_set = try serde.deserializeReservedInstanceReservationValueSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "targetConfigurationValueRollup")) {
                    result.target_configuration_value_rollup = try serde.deserializeReservationValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "targetConfigurationValueSet")) {
                    result.target_configuration_value_set = try serde.deserializeTargetReservationValueSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "validationFailureReason")) {
                    result.validation_failure_reason = try alloc.dupe(u8, try reader.readElementText());
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
