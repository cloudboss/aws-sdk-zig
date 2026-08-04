const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const QualificationTypeStatus = @import("qualification_type_status.zig").QualificationTypeStatus;
const QualificationType = @import("qualification_type.zig").QualificationType;

pub const CreateQualificationTypeInput = struct {
    /// The answers to the Qualification test specified in the Test
    /// parameter, in the form of an AnswerKey data structure.
    ///
    /// Constraints: Must not be longer than 65535 bytes.
    ///
    /// Constraints: None. If not specified, you must process
    /// Qualification requests manually.
    answer_key: ?[]const u8 = null,

    /// Specifies whether requests for the Qualification type are
    /// granted immediately, without prompting the Worker with a
    /// Qualification test.
    ///
    /// Constraints: If the Test parameter is specified, this
    /// parameter cannot be true.
    auto_granted: ?bool = null,

    /// The Qualification value to use for automatically granted
    /// Qualifications. This parameter is used only if the AutoGranted
    /// parameter is true.
    auto_granted_value: ?i32 = null,

    /// A long description for the Qualification type. On the Amazon
    /// Mechanical Turk website, the long description is displayed when a
    /// Worker examines a Qualification type.
    description: []const u8,

    /// One or more words or phrases that describe the Qualification
    /// type, separated by commas. The keywords of a type make the type
    /// easier to find during a search.
    keywords: ?[]const u8 = null,

    /// The name you give to the Qualification type. The type name
    /// is used to represent the Qualification to Workers, and to find the
    /// type using a Qualification type search. It must be unique across all
    /// of your Qualification types.
    name: []const u8,

    /// The initial status of the Qualification type.
    ///
    /// Constraints: Valid values are: Active | Inactive
    qualification_type_status: QualificationTypeStatus,

    /// The number of seconds that a Worker must wait after
    /// requesting a Qualification of the Qualification type before the
    /// worker can retry the Qualification request.
    ///
    /// Constraints: None. If not specified, retries are disabled and
    /// Workers can request a Qualification of this type only once, even if
    /// the Worker has not been granted the Qualification. It is not possible
    /// to disable retries for a Qualification type after it has been created
    /// with retries enabled. If you want to disable retries, you must delete
    /// existing retry-enabled Qualification type and then create a new
    /// Qualification type with retries disabled.
    retry_delay_in_seconds: ?i64 = null,

    /// The questions for the Qualification test a Worker must answer
    /// correctly to obtain a Qualification of this type. If this parameter
    /// is specified,
    /// `TestDurationInSeconds`
    /// must also be specified.
    ///
    /// Constraints: Must not be longer than 65535 bytes. Must be a
    /// QuestionForm data structure. This parameter cannot be specified if
    /// AutoGranted is true.
    ///
    /// Constraints: None. If not specified, the Worker may request
    /// the Qualification without answering any questions.
    @"test": ?[]const u8 = null,

    /// The number of seconds the Worker has to complete the
    /// Qualification test, starting from the time the Worker requests the
    /// Qualification.
    test_duration_in_seconds: ?i64 = null,

    pub const json_field_names = .{
        .answer_key = "AnswerKey",
        .auto_granted = "AutoGranted",
        .auto_granted_value = "AutoGrantedValue",
        .description = "Description",
        .keywords = "Keywords",
        .name = "Name",
        .qualification_type_status = "QualificationTypeStatus",
        .retry_delay_in_seconds = "RetryDelayInSeconds",
        .@"test" = "Test",
        .test_duration_in_seconds = "TestDurationInSeconds",
    };
};

pub const CreateQualificationTypeOutput = struct {
    /// The created Qualification type, returned as a
    /// QualificationType data structure.
    qualification_type: ?QualificationType = null,

    pub const json_field_names = .{
        .qualification_type = "QualificationType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQualificationTypeInput, options: CallOptions) !CreateQualificationTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mturk-requester", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQualificationTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk-requester", "MTurk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.CreateQualificationType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQualificationTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateQualificationTypeOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.RequestError = aws.json.parseJsonObject(errors.RequestError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceFault")) {
        const parsed_error: ?errors.ServiceFault = aws.json.parseJsonObject(errors.ServiceFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_fault = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
