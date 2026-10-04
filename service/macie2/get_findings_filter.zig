const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingsFilterAction = @import("findings_filter_action.zig").FindingsFilterAction;
const FindingCriteria = @import("finding_criteria.zig").FindingCriteria;

pub const GetFindingsFilterInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetFindingsFilterOutput = struct {
    /// The action that's performed on findings that match the filter criteria
    /// (findingCriteria). Possible values are: ARCHIVE, suppress (automatically
    /// archive) the findings; and, NOOP, don't perform any action on the findings.
    action: ?FindingsFilterAction = null,

    /// The Amazon Resource Name (ARN) of the filter.
    arn: ?[]const u8 = null,

    /// The custom description of the filter.
    description: ?[]const u8 = null,

    /// The criteria that's used to filter findings.
    finding_criteria: ?FindingCriteria = null,

    /// The unique identifier for the filter.
    id: ?[]const u8 = null,

    /// The custom name of the filter.
    name: ?[]const u8 = null,

    /// The position of the filter in the list of saved filters on the Amazon Macie
    /// console. This value also determines the order in which the filter is applied
    /// to findings, relative to other filters that are also applied to the
    /// findings.
    position: ?i32 = null,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the filter.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .description = "description",
        .finding_criteria = "findingCriteria",
        .id = "id",
        .name = "name",
        .position = "position",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsFilterInput, options: CallOptions) !GetFindingsFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/findingsfilters/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsFilterOutput {
    const result: GetFindingsFilterOutput = try aws.json.parseJsonObject(
        GetFindingsFilterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
