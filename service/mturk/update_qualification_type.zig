const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQualificationTypeInput, options: CallOptions) !UpdateQualificationTypeOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQualificationTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.UpdateQualificationType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQualificationTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateQualificationTypeOutput, body, allocator);
}
