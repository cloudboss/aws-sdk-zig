const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiKeyRestrictions = @import("api_key_restrictions.zig").ApiKeyRestrictions;

pub const DescribeKeyInput = struct {
    /// The name of the API key resource.
    key_name: []const u8,

    pub const json_field_names = .{
        .key_name = "KeyName",
    };
};

pub const DescribeKeyOutput = struct {
    /// The timestamp for when the API key resource was created in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The optional description for the API key resource.
    description: ?[]const u8 = null,

    /// The timestamp for when the API key resource will expire in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    expire_time: i64,

    /// The key value/string of an API key.
    key: []const u8,

    /// The Amazon Resource Name (ARN) for the API key resource. Used when you need
    /// to specify a resource across all Amazon Web Services.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:key/ExampleKey`
    key_arn: []const u8,

    /// The name of the API key resource.
    key_name: []const u8,

    restrictions: ?ApiKeyRestrictions = null,

    /// Tags associated with the API key resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the API key resource was last updated in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .description = "Description",
        .expire_time = "ExpireTime",
        .key = "Key",
        .key_arn = "KeyArn",
        .key_name = "KeyName",
        .restrictions = "Restrictions",
        .tags = "Tags",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeKeyInput, options: CallOptions) !DescribeKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metadata/v0/keys/");
    try path_buf.appendSlice(allocator, input.key_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeKeyOutput {
    var result: DescribeKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeKeyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
