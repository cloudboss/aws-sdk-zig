const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetFileUploadURLInput = struct {
    /// The ID of the assignment that contains the question with a
    /// FileUploadAnswer.
    assignment_id: []const u8,

    /// The identifier of the question with a FileUploadAnswer, as
    /// specified in the QuestionForm of the HIT.
    question_identifier: []const u8,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .question_identifier = "QuestionIdentifier",
    };
};

pub const GetFileUploadURLOutput = struct {
    /// A temporary URL for the file that the Worker uploaded for
    /// the answer.
    file_upload_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_upload_url = "FileUploadURL",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFileUploadURLInput, options: CallOptions) !GetFileUploadURLOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFileUploadURLInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.GetFileUploadURL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFileUploadURLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetFileUploadURLOutput, body, allocator);
}
