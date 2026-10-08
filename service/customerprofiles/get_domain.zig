const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataStoreResponse = @import("data_store_response.zig").DataStoreResponse;
const MatchingResponse = @import("matching_response.zig").MatchingResponse;
const RuleBasedMatchingResponse = @import("rule_based_matching_response.zig").RuleBasedMatchingResponse;
const DomainStats = @import("domain_stats.zig").DomainStats;

pub const GetDomainInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetDomainOutput = struct {
    /// The timestamp of when the domain was created.
    created_at: i64,

    /// True if data store is enabled for this domain.
    data_store: ?DataStoreResponse = null,

    /// The URL of the SQS dead letter queue, which is used for reporting errors
    /// associated with
    /// ingesting data from third party applications.
    dead_letter_queue_url: ?[]const u8 = null,

    /// The default encryption key, which is an AWS managed key, is used when no
    /// specific type
    /// of encryption key is specified. It is used to encrypt all data before it is
    /// placed in
    /// permanent or semi-permanent storage.
    default_encryption_key: ?[]const u8 = null,

    /// The default number of days until the data within the domain expires.
    default_expiration_days: ?i32 = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// The timestamp of when the domain was most recently edited.
    last_updated_at: i64,

    /// The process of matching duplicate profiles. If `Matching` = `true`, Amazon
    /// Connect Customer Profiles starts a weekly
    /// batch process called Identity Resolution Job. If you do not specify a date
    /// and time for Identity Resolution Job to run, by default it runs every
    /// Saturday at 12AM UTC to detect duplicate profiles in your domains.
    ///
    /// After the Identity Resolution Job completes, use the
    /// [GetMatches](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html)
    /// API to return and review the results. Or, if you have configured
    /// `ExportingConfig` in the `MatchingRequest`, you can download the results
    /// from
    /// S3.
    matching: ?MatchingResponse = null,

    /// The process of matching duplicate profiles using the Rule-Based matching. If
    /// `RuleBasedMatching` = true, Connect Customer Customer Profiles will start
    /// to match and merge your profiles according to your configuration in the
    /// `RuleBasedMatchingRequest`. You can use the `ListRuleBasedMatches`
    /// and `GetSimilarProfiles` API to return and review the results. Also, if you
    /// have
    /// configured `ExportingConfig` in the `RuleBasedMatchingRequest`, you
    /// can download the results from S3.
    rule_based_matching: ?RuleBasedMatchingResponse = null,

    /// Usage-specific statistics about the domain.
    stats: ?DomainStats = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_store = "DataStore",
        .dead_letter_queue_url = "DeadLetterQueueUrl",
        .default_encryption_key = "DefaultEncryptionKey",
        .default_expiration_days = "DefaultExpirationDays",
        .domain_name = "DomainName",
        .last_updated_at = "LastUpdatedAt",
        .matching = "Matching",
        .rule_based_matching = "RuleBasedMatching",
        .stats = "Stats",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDomainInput, options: CallOptions) !GetDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDomainOutput {
    const result: GetDomainOutput = try aws.json.parseJsonObject(
        GetDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
