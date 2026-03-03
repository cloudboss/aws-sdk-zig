const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QualificationTypeStatus = @import("qualification_type_status.zig").QualificationTypeStatus;
const QualificationType = @import("qualification_type.zig").QualificationType;

pub const UpdateQualificationTypeInput = struct {
    /// The answers to the Qualification test specified in the Test parameter, in
    /// the form of an AnswerKey data structure.
    answer_key: ?[]const u8 = null,

    /// Specifies whether requests for the Qualification type are granted
    /// immediately, without prompting the Worker with a Qualification test.
    ///
    /// Constraints: If the Test parameter is specified, this parameter cannot be
    /// true.
    auto_granted: ?bool = null,

    /// The Qualification value to use for automatically granted Qualifications.
    /// This parameter is used only if the AutoGranted parameter is true.
    auto_granted_value: ?i32 = null,

    /// The new description of the Qualification type.
    description: ?[]const u8 = null,

    /// The ID of the Qualification type to update.
    qualification_type_id: []const u8,

    /// The new status of the Qualification type - Active | Inactive
    qualification_type_status: ?QualificationTypeStatus = null,

    /// The amount of time, in seconds, that Workers must wait
    /// after requesting a Qualification of the specified Qualification type
    /// before they can retry the Qualification request. It is not possible to
    /// disable retries for a Qualification type after it has been created with
    /// retries enabled. If you want to disable retries, you must dispose of
    /// the existing retry-enabled Qualification type using
    /// DisposeQualificationType and then create a new Qualification type with
    /// retries disabled using CreateQualificationType.
    retry_delay_in_seconds: ?i64 = null,

    /// The questions for the Qualification test a Worker must answer correctly to
    /// obtain a Qualification of this type. If this parameter is specified,
    /// `TestDurationInSeconds` must also be specified.
    ///
    /// Constraints: Must not be longer than 65535 bytes. Must be a QuestionForm
    /// data structure. This parameter cannot be specified if AutoGranted is true.
    ///
    /// Constraints: None. If not specified, the Worker may request the
    /// Qualification without answering any questions.
    @"test": ?[]const u8 = null,

    /// The number of seconds the Worker has to complete the Qualification test,
    /// starting from the time the Worker requests the Qualification.
    test_duration_in_seconds: ?i64 = null,

    pub const json_field_names = .{
        .answer_key = "AnswerKey",
        .auto_granted = "AutoGranted",
        .auto_granted_value = "AutoGrantedValue",
        .description = "Description",
        .qualification_type_id = "QualificationTypeId",
        .qualification_type_status = "QualificationTypeStatus",
        .retry_delay_in_seconds = "RetryDelayInSeconds",
        .@"test" = "Test",
        .test_duration_in_seconds = "TestDurationInSeconds",
    };
};

pub const UpdateQualificationTypeOutput = struct {
    /// Contains a QualificationType data structure.
    qualification_type: ?QualificationType = null,

    pub const json_field_names = .{
        .qualification_type = "QualificationType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQualificationTypeInput, options: Options) !UpdateQualificationTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQualificationTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.UpdateQualificationType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQualificationTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateQualificationTypeOutput, body, allocator);
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
