const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeedbackRating = @import("feedback_rating.zig").FeedbackRating;
const FeedbackReasonCode = @import("feedback_reason_code.zig").FeedbackReasonCode;

pub const PutComplianceInquiryFeedbackInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// An optional comment for the feedback.
    comment: ?[]const u8 = null,

    /// The unique identifier for the compliance inquiry.
    compliance_inquiry_id: []const u8,

    /// The sequential identifier of the query to provide feedback on.
    query_identifier: ?i32 = null,

    /// The rating for the feedback. Valid values are THUMBS_UP and THUMBS_DOWN.
    rating: FeedbackRating,

    /// The reason codes that describe why you rated the response. Valid values are
    /// OTHER, PARTIAL_RESPONSE, and IRRELEVANT_RESPONSE.
    reason_codes: ?[]const FeedbackReasonCode = null,

    /// The response revision ID. Use this value to prevent submitting feedback on a
    /// stale response.
    response_revision_id: ?i32 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .comment = "comment",
        .compliance_inquiry_id = "complianceInquiryId",
        .query_identifier = "queryIdentifier",
        .rating = "rating",
        .reason_codes = "reasonCodes",
        .response_revision_id = "responseRevisionId",
    };
};

pub const PutComplianceInquiryFeedbackOutput = struct {
    /// The timestamp when the feedback was submitted.
    submitted_at: i64,

    pub const json_field_names = .{
        .submitted_at = "submittedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutComplianceInquiryFeedbackInput, options: CallOptions) !PutComplianceInquiryFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "artifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutComplianceInquiryFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/compliance-inquiry/putFeedback";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"complianceInquiryId\":");
    try aws.json.writeValue(@TypeOf(input.compliance_inquiry_id), input.compliance_inquiry_id, allocator, &body_buf);
    has_prev = true;
    if (input.query_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"rating\":");
    try aws.json.writeValue(@TypeOf(input.rating), input.rating, allocator, &body_buf);
    has_prev = true;
    if (input.reason_codes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reasonCodes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseRevisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutComplianceInquiryFeedbackOutput {
    const result: PutComplianceInquiryFeedbackOutput = try aws.json.parseJsonObject(
        PutComplianceInquiryFeedbackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
