const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MembershipProtectedJobResultConfiguration = @import("membership_protected_job_result_configuration.zig").MembershipProtectedJobResultConfiguration;
const MembershipProtectedQueryResultConfiguration = @import("membership_protected_query_result_configuration.zig").MembershipProtectedQueryResultConfiguration;
const MembershipJobLogStatus = @import("membership_job_log_status.zig").MembershipJobLogStatus;
const MembershipPaymentConfiguration = @import("membership_payment_configuration.zig").MembershipPaymentConfiguration;
const MembershipQueryLogStatus = @import("membership_query_log_status.zig").MembershipQueryLogStatus;
const Membership = @import("membership.zig").Membership;

pub const CreateMembershipInput = struct {
    /// The unique ID for the associated collaboration.
    collaboration_identifier: []const u8,

    /// The default job result configuration that determines how job results are
    /// protected and managed within this membership. This configuration applies to
    /// all jobs.
    default_job_result_configuration: ?MembershipProtectedJobResultConfiguration = null,

    /// The default protected query result configuration as specified by the member
    /// who can receive results.
    default_result_configuration: ?MembershipProtectedQueryResultConfiguration = null,

    /// An indicator as to whether Amazon CloudWatch metrics have been enabled or
    /// disabled for the membership.
    ///
    /// Amazon CloudWatch metrics are only available when the collaboration has
    /// metrics enabled. This option can be set by collaboration members who have
    /// the ability to run queries (analysis runners) or by members who are
    /// configured as payers.
    ///
    /// When `true`, metrics about query execution are collected in Amazon
    /// CloudWatch. The default value is `false`.
    is_metrics_enabled: ?bool = null,

    /// An indicator as to whether job logging has been enabled or disabled for the
    /// collaboration.
    ///
    /// When `ENABLED`, Clean Rooms logs details about jobs run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    job_log_status: ?MembershipJobLogStatus = null,

    /// The payment responsibilities accepted by the collaboration member.
    ///
    /// Not required if the collaboration member has the member ability to run
    /// queries.
    ///
    /// Required if the collaboration member doesn't have the member ability to run
    /// queries but is configured as a payer by the collaboration creator.
    payment_configuration: ?MembershipPaymentConfiguration = null,

    /// An indicator as to whether query logging has been enabled or disabled for
    /// the membership.
    ///
    /// When `ENABLED`, Clean Rooms logs details about queries run within this
    /// collaboration and those logs can be viewed in Amazon CloudWatch Logs. The
    /// default value is `DISABLED`.
    query_log_status: MembershipQueryLogStatus,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .default_job_result_configuration = "defaultJobResultConfiguration",
        .default_result_configuration = "defaultResultConfiguration",
        .is_metrics_enabled = "isMetricsEnabled",
        .job_log_status = "jobLogStatus",
        .payment_configuration = "paymentConfiguration",
        .query_log_status = "queryLogStatus",
        .tags = "tags",
    };
};

pub const CreateMembershipOutput = struct {
    /// The membership that was created.
    membership: ?Membership = null,

    pub const json_field_names = .{
        .membership = "membership",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMembershipInput, options: CallOptions) !CreateMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/memberships";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"collaborationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.collaboration_identifier), input.collaboration_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.default_job_result_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultJobResultConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_result_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultResultConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_metrics_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isMetricsEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_log_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobLogStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.payment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"paymentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryLogStatus\":");
    try aws.json.writeValue(@TypeOf(input.query_log_status), input.query_log_status, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMembershipOutput {
    const result: CreateMembershipOutput = try aws.json.parseJsonObject(
        CreateMembershipOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
