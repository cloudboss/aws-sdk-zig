const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SegmentGroup = @import("segment_group.zig").SegmentGroup;
const SegmentSort = @import("segment_sort.zig").SegmentSort;
const SegmentType = @import("segment_type.zig").SegmentType;

pub const GetSegmentDefinitionInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique name of the segment definition.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const GetSegmentDefinitionOutput = struct {
    /// The timestamp of when the segment definition was created.
    created_at: ?i64 = null,

    /// The description of the segment definition.
    description: ?[]const u8 = null,

    /// The display name of the segment definition.
    display_name: ?[]const u8 = null,

    /// The arn of the segment definition.
    segment_definition_arn: []const u8,

    /// The name of the segment definition.
    segment_definition_name: ?[]const u8 = null,

    /// The segment criteria associated with this definition.
    segment_groups: ?SegmentGroup = null,

    /// The segment sort.
    segment_sort: ?SegmentSort = null,

    /// The segment SQL query.
    segment_sql_query: ?[]const u8 = null,

    /// The segment type.
    ///
    /// Classic : Segments created using traditional SegmentGroup structure
    ///
    /// Enhanced : Segments created using SQL queries
    segment_type: ?SegmentType = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .display_name = "DisplayName",
        .segment_definition_arn = "SegmentDefinitionArn",
        .segment_definition_name = "SegmentDefinitionName",
        .segment_groups = "SegmentGroups",
        .segment_sort = "SegmentSort",
        .segment_sql_query = "SegmentSqlQuery",
        .segment_type = "SegmentType",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentDefinitionInput, options: CallOptions) !GetSegmentDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-definitions/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentDefinitionOutput {
    var result: GetSegmentDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSegmentDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
