const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReviewPolicy = @import("review_policy.zig").ReviewPolicy;
const HITLayoutParameter = @import("hit_layout_parameter.zig").HITLayoutParameter;
const HIT = @import("hit.zig").HIT;

pub const CreateHITWithHITTypeInput = struct {
    /// The Assignment-level Review Policy applies to the assignments under the HIT.
    /// You can specify for Mechanical Turk to take various actions based on the
    /// policy.
    assignment_review_policy: ?ReviewPolicy = null,

    /// The HITLayoutId allows you to use a pre-existing HIT design with placeholder
    /// values
    /// and create an additional HIT by providing those values as
    /// HITLayoutParameters.
    ///
    /// Constraints: Either a Question parameter or a HITLayoutId parameter must be
    /// provided.
    hit_layout_id: ?[]const u8 = null,

    /// If the HITLayoutId is provided, any placeholder values must be filled in
    /// with values
    /// using the HITLayoutParameter structure. For more information, see HITLayout.
    hit_layout_parameters: ?[]const HITLayoutParameter = null,

    /// The HIT-level Review Policy applies to the HIT.
    /// You can specify for Mechanical Turk to take various actions based on the
    /// policy.
    hit_review_policy: ?ReviewPolicy = null,

    /// The HIT type ID you want to create this HIT with.
    hit_type_id: []const u8,

    /// An amount of time, in seconds, after which the HIT is no longer available
    /// for users to accept.
    /// After the lifetime of the HIT elapses, the HIT no longer appears in HIT
    /// searches,
    /// even if not all of the assignments for the HIT have been accepted.
    lifetime_in_seconds: i64,

    /// The number of times the HIT can be accepted and completed before the HIT
    /// becomes unavailable.
    max_assignments: ?i32 = null,

    /// The data the person completing the HIT uses to produce the results.
    ///
    /// Constraints: Must be a QuestionForm data structure, an ExternalQuestion data
    /// structure,
    /// or an HTMLQuestion data structure. The XML question data must not be larger
    /// than
    /// 64 kilobytes (65,535 bytes) in size, including whitespace.
    ///
    /// Either a Question parameter or a HITLayoutId parameter must be provided.
    question: ?[]const u8 = null,

    /// An arbitrary data field.
    /// The RequesterAnnotation parameter lets your application attach arbitrary
    /// data
    /// to the HIT for tracking purposes.
    /// For example, this parameter could be an identifier internal to the
    /// Requester's application
    /// that corresponds with the HIT.
    ///
    /// The RequesterAnnotation parameter for a HIT is only visible to the Requester
    /// who created the HIT.
    /// It is not shown to the Worker, or any other Requester.
    ///
    /// The RequesterAnnotation parameter may be different for each HIT you submit.
    /// It does not affect how your HITs are grouped.
    requester_annotation: ?[]const u8 = null,

    /// A unique identifier for this request which allows you to retry the call
    /// on error without creating duplicate HITs.
    /// This is useful in cases such as network timeouts where it is unclear whether
    /// or not
    /// the call succeeded on the server.
    /// If the HIT already exists in the system from a previous call using the same
    /// UniqueRequestToken,
    /// subsequent calls will return a AWS.MechanicalTurk.HitAlreadyExists error
    /// with a message containing the HITId.
    ///
    /// Note: It is your responsibility to ensure uniqueness of the token.
    /// The unique token expires after 24 hours. Subsequent calls using the same
    /// UniqueRequestToken made after the 24 hour limit could create duplicate HITs.
    unique_request_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_review_policy = "AssignmentReviewPolicy",
        .hit_layout_id = "HITLayoutId",
        .hit_layout_parameters = "HITLayoutParameters",
        .hit_review_policy = "HITReviewPolicy",
        .hit_type_id = "HITTypeId",
        .lifetime_in_seconds = "LifetimeInSeconds",
        .max_assignments = "MaxAssignments",
        .question = "Question",
        .requester_annotation = "RequesterAnnotation",
        .unique_request_token = "UniqueRequestToken",
    };
};

pub const CreateHITWithHITTypeOutput = struct {
    /// Contains the newly created HIT data. For a description of
    /// the HIT data structure as it appears in responses, see the HIT Data
    /// Structure documentation.
    hit: ?HIT = null,

    pub const json_field_names = .{
        .hit = "HIT",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHITWithHITTypeInput, options: Options) !CreateHITWithHITTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mturk");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHITWithHITTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk", "MTurk", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.CreateHITWithHITType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHITWithHITTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHITWithHITTypeOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "RequestError")) {
        return .{ .arena = arena, .kind = .{ .request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFault")) {
        return .{ .arena = arena, .kind = .{ .service_fault = .{
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
