const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngagementProspectingResult = @import("engagement_prospecting_result.zig").EngagementProspectingResult;

pub const GetProspectingFromEngagementTaskInput = struct {
    /// Specifies the catalog associated with the task. Specify `AWS` for production
    /// environments and `Sandbox` for testing and development purposes. The value
    /// must match the catalog used when the task was created.
    catalog: []const u8,

    /// The unique identifier of the prospecting task to retrieve. This value is
    /// returned in the `TaskId` field of the `StartProspectingFromEngagementTask`
    /// response.
    task_identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .task_identifier = "TaskIdentifier",
    };
};

pub const GetProspectingFromEngagementTaskOutput = struct {
    /// The timestamp indicating when the task finished processing. This field is
    /// absent if the task is still in progress. The format follows ISO 8601
    /// date-time notation.
    end_time: ?i64 = null,

    /// An array of `EngagementProspectingResult` entries for each engagement in the
    /// task. Each entry contains the processing status. For successfully completed
    /// engagements, includes the prospecting context identifier. For failed
    /// engagements, includes an error code and message.
    engagements: ?[]const EngagementProspectingResult = null,

    /// The timestamp indicating when the task was initiated. The format follows ISO
    /// 8601 date-time notation.
    start_time: i64,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: []const u8,

    /// The unique identifier of the task.
    task_id: []const u8,

    /// The descriptive name of the task that you provided when you created it.
    task_name: []const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .engagements = "Engagements",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_name = "TaskName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProspectingFromEngagementTaskInput, options: CallOptions) !GetProspectingFromEngagementTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProspectingFromEngagementTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetProspectingFromEngagementTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProspectingFromEngagementTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetProspectingFromEngagementTaskOutput, body, allocator);
}
