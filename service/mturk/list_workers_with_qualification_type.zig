const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QualificationStatus = @import("qualification_status.zig").QualificationStatus;
const Qualification = @import("qualification.zig").Qualification;

pub const ListWorkersWithQualificationTypeInput = struct {
    /// Limit the number of results returned.
    max_results: ?i32 = null,

    /// Pagination Token
    next_token: ?[]const u8 = null,

    /// The ID of the Qualification type of the Qualifications to
    /// return.
    qualification_type_id: []const u8,

    /// The status of the Qualifications to return.
    /// Can be `Granted | Revoked`.
    status: ?QualificationStatus = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .qualification_type_id = "QualificationTypeId",
        .status = "Status",
    };
};

pub const ListWorkersWithQualificationTypeOutput = struct {
    next_token: ?[]const u8 = null,

    /// The number of Qualifications on this page in the filtered
    /// results list, equivalent to the number of Qualifications being
    /// returned by this call.
    num_results: ?i32 = null,

    /// The list of Qualification elements returned by this call.
    qualifications: ?[]const Qualification = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .num_results = "NumResults",
        .qualifications = "Qualifications",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkersWithQualificationTypeInput, options: CallOptions) !ListWorkersWithQualificationTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkersWithQualificationTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListWorkersWithQualificationType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkersWithQualificationTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListWorkersWithQualificationTypeOutput, body, allocator);
}
