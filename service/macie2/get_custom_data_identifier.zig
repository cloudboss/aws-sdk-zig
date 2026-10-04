const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SeverityLevel = @import("severity_level.zig").SeverityLevel;

pub const GetCustomDataIdentifierInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetCustomDataIdentifierOutput = struct {
    /// The Amazon Resource Name (ARN) of the custom data identifier.
    arn: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the custom data
    /// identifier was created.
    created_at: ?i64 = null,

    /// Specifies whether the custom data identifier was deleted. If you delete a
    /// custom data identifier, Amazon Macie doesn't delete it permanently. Instead,
    /// it soft deletes the identifier.
    deleted: ?bool = null,

    /// The custom description of the custom data identifier.
    description: ?[]const u8 = null,

    /// The unique identifier for the custom data identifier.
    id: ?[]const u8 = null,

    /// An array that lists specific character sequences (*ignore words*) to exclude
    /// from the results. If the text matched by the regular expression contains any
    /// string in this array, Amazon Macie ignores it. Ignore words are case
    /// sensitive.
    ignore_words: ?[]const []const u8 = null,

    /// An array that lists specific character sequences (*keywords*), one of which
    /// must precede and be within proximity (maximumMatchDistance) of the regular
    /// expression to match. Keywords aren't case sensitive.
    keywords: ?[]const []const u8 = null,

    /// The maximum number of characters that can exist between the end of at least
    /// one complete character sequence specified by the keywords array and the end
    /// of the text that matches the regex pattern. If a complete keyword precedes
    /// all the text that matches the pattern and the keyword is within the
    /// specified distance, Amazon Macie includes the result. Otherwise, Macie
    /// excludes the result.
    maximum_match_distance: ?i32 = null,

    /// The custom name of the custom data identifier.
    name: ?[]const u8 = null,

    /// The regular expression (*regex*) that defines the pattern to match.
    regex: ?[]const u8 = null,

    /// Specifies the severity that's assigned to findings that the custom data
    /// identifier produces, based on the number of occurrences of text that match
    /// the custom data identifier's detection criteria. By default, Amazon Macie
    /// creates findings for S3 objects that contain at least one occurrence of text
    /// that matches the detection criteria, and Macie assigns the MEDIUM severity
    /// to those findings.
    severity_levels: ?[]const SeverityLevel = null,

    /// A map of key-value pairs that identifies the tags (keys and values) that are
    /// associated with the custom data identifier.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .deleted = "deleted",
        .description = "description",
        .id = "id",
        .ignore_words = "ignoreWords",
        .keywords = "keywords",
        .maximum_match_distance = "maximumMatchDistance",
        .name = "name",
        .regex = "regex",
        .severity_levels = "severityLevels",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCustomDataIdentifierInput, options: CallOptions) !GetCustomDataIdentifierOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCustomDataIdentifierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-data-identifiers/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCustomDataIdentifierOutput {
    const result: GetCustomDataIdentifierOutput = try aws.json.parseJsonObject(
        GetCustomDataIdentifierOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
