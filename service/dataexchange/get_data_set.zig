const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetType = @import("asset_type.zig").AssetType;
const Origin = @import("origin.zig").Origin;
const OriginDetails = @import("origin_details.zig").OriginDetails;

pub const GetDataSetInput = struct {
    /// The unique identifier for a data set.
    data_set_id: []const u8,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
    };
};

pub const GetDataSetOutput = struct {
    /// The ARN for the data set.
    arn: ?[]const u8 = null,

    /// The type of asset that is added to a data set.
    asset_type: ?AssetType = null,

    /// The date and time that the data set was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The description for the data set.
    description: ?[]const u8 = null,

    /// The unique identifier for the data set.
    id: ?[]const u8 = null,

    /// The name of the data set.
    name: ?[]const u8 = null,

    /// A property that defines the data set as OWNED by the account (for providers)
    /// or ENTITLED to the account (for subscribers).
    origin: ?Origin = null,

    /// If the origin of this data set is ENTITLED, includes the details for the
    /// product on AWS Marketplace.
    origin_details: ?OriginDetails = null,

    /// The data set ID of the owned data set corresponding to the entitled data set
    /// being viewed. This parameter is returned when a data set owner is viewing
    /// the entitled copy of its owned data set.
    source_id: ?[]const u8 = null,

    /// The tags for the data set.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time that the data set was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_type = "AssetType",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .origin = "Origin",
        .origin_details = "OriginDetails",
        .source_id = "SourceId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSetInput, options: CallOptions) !GetDataSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/data-sets/");
    try path_buf.appendSlice(allocator, input.data_set_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSetOutput {
    var result: GetDataSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
