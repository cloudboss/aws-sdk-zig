const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndDateType = @import("end_date_type.zig").EndDateType;
const InstanceMatchCriteria = @import("instance_match_criteria.zig").InstanceMatchCriteria;
const CapacityReservationAdjustmentDetails = @import("capacity_reservation_adjustment_details.zig").CapacityReservationAdjustmentDetails;
const CapacityReservationAdjustmentStatus = @import("capacity_reservation_adjustment_status.zig").CapacityReservationAdjustmentStatus;
const serde = @import("serde.zig");

pub const ModifyCapacityReservationInput = @import("modify_capacity_reservation_request.zig").ModifyCapacityReservationRequest;

pub const ModifyCapacityReservationOutput = @import("modify_capacity_reservation_result.zig").ModifyCapacityReservationResult;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, options: CallOptions) !ModifyCapacityReservationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCapacityReservation&Version=2016-11-15");
    if (input.accept) |v| {
        try body_buf.appendSlice(allocator, "&Accept=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.accept_modification_terms) |v| {
        try body_buf.appendSlice(allocator, "&AcceptModificationTerms=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.additional_info) |v| {
        try body_buf.appendSlice(allocator, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(allocator, "&EndDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.end_date_type) |v| {
        try body_buf.appendSlice(allocator, "&EndDateType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(allocator, "&InstanceCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.instance_match_criteria) |v| {
        try body_buf.appendSlice(allocator, "&InstanceMatchCriteria=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.quote_id) |v| {
        try body_buf.appendSlice(allocator, "&QuoteId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.start_date) |v| {
        try body_buf.appendSlice(allocator, "&StartDate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCapacityReservationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyCapacityReservationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "adjustmentDetails")) {
                    result.adjustment_details = try serde.deserializeCapacityReservationAdjustmentDetails(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "adjustmentStatus")) {
                    result.adjustment_status = CapacityReservationAdjustmentStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
