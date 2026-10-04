const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ByteMatchSet = @import("byte_match_set.zig").ByteMatchSet;

pub const GetByteMatchSetInput = struct {
    /// The `ByteMatchSetId` of the ByteMatchSet that you want to get.
    /// `ByteMatchSetId` is returned by
    /// CreateByteMatchSet and by ListByteMatchSets.
    byte_match_set_id: []const u8,

    pub const json_field_names = .{
        .byte_match_set_id = "ByteMatchSetId",
    };
};

pub const GetByteMatchSetOutput = struct {
    /// Information about the ByteMatchSet that you specified in the
    /// `GetByteMatchSet` request. For more information, see the
    /// following topics:
    ///
    /// * ByteMatchSet: Contains `ByteMatchSetId`, `ByteMatchTuples`, and `Name`
    ///
    /// * `ByteMatchTuples`: Contains an array of ByteMatchTuple objects. Each
    ///   `ByteMatchTuple`
    /// object contains FieldToMatch, `PositionalConstraint`, `TargetString`,
    /// and `TextTransformation`
    ///
    /// * FieldToMatch: Contains `Data` and `Type`
    byte_match_set: ?ByteMatchSet = null,

    pub const json_field_names = .{
        .byte_match_set = "ByteMatchSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetByteMatchSetInput, options: CallOptions) !GetByteMatchSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetByteMatchSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf", "WAF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.GetByteMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetByteMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetByteMatchSetOutput, body, allocator);
}
