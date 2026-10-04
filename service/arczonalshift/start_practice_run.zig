const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ZonalShiftStatus = @import("zonal_shift_status.zig").ZonalShiftStatus;

pub const StartPracticeRunInput = struct {
    /// The Availability Zone (for example, `use1-az1`) that traffic is shifted away
    /// from for the resource that you specify for the practice run.
    away_from: []const u8,

    /// The initial comment that you enter about the practice run. Be aware that
    /// this comment can be overwritten by Amazon Web Services if the automatic
    /// check for balanced capacity fails. For more information, see [ Capacity
    /// checks for practice
    /// runs](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.how-it-works.capacity-check.html) in the Amazon Application Recovery Controller Developer Guide.
    comment: []const u8,

    /// The identifier for the resource that you want to start a practice run zonal
    /// shift for. The identifier is the Amazon Resource Name (ARN) for the
    /// resource.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .away_from = "awayFrom",
        .comment = "comment",
        .resource_identifier = "resourceIdentifier",
    };
};

pub const StartPracticeRunOutput = struct {
    /// The Availability Zone (for example, `use1-az1`) that traffic is shifted away
    /// from for the resource that you specify for the practice run.
    away_from: []const u8,

    /// The initial comment that you enter about the practice run. Be aware that
    /// this comment can be overwritten by Amazon Web Services if the automatic
    /// check for balanced capacity fails. For more information, see [ Capacity
    /// checks for practice
    /// runs](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.how-it-works.capacity-check.html) in the Amazon Application Recovery Controller Developer Guide.
    comment: []const u8,

    /// The expiry time (expiration time) for an on-demand practice run zonal shift
    /// is 30 minutes from the time when you start the practice run, unless you
    /// cancel it before that time. However, be aware that the `expiryTime` field
    /// for practice run zonal shifts always has a value of 1 minute.
    expiry_time: i64,

    /// The identifier for the resource that you want to shift traffic for. The
    /// identifier is the Amazon Resource Name (ARN) for the resource.
    resource_identifier: []const u8,

    /// The time (UTC) when the zonal shift starts.
    start_time: i64,

    /// A status for the practice run (expected status is **ACTIVE**).
    status: ZonalShiftStatus,

    /// The identifier of a practice run zonal shift.
    zonal_shift_id: []const u8,

    pub const json_field_names = .{
        .away_from = "awayFrom",
        .comment = "comment",
        .expiry_time = "expiryTime",
        .resource_identifier = "resourceIdentifier",
        .start_time = "startTime",
        .status = "status",
        .zonal_shift_id = "zonalShiftId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPracticeRunInput, options: CallOptions) !StartPracticeRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "percdataplane", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPracticeRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/practiceruns";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"awayFrom\":");
    try aws.json.writeValue(@TypeOf(input.away_from), input.away_from, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"comment\":");
    try aws.json.writeValue(@TypeOf(input.comment), input.comment, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.resource_identifier), input.resource_identifier, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPracticeRunOutput {
    const result: StartPracticeRunOutput = try aws.json.parseJsonObject(
        StartPracticeRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
