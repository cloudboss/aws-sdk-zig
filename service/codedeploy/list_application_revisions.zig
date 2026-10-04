const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListStateFilterAction = @import("list_state_filter_action.zig").ListStateFilterAction;
const ApplicationRevisionSortBy = @import("application_revision_sort_by.zig").ApplicationRevisionSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;

pub const ListApplicationRevisionsInput = struct {
    /// The name of an CodeDeploy application associated with the user or Amazon Web
    /// Services account.
    application_name: []const u8,

    /// Whether to list revisions based on whether the revision is the target
    /// revision of a
    /// deployment group:
    ///
    /// * `include`: List revisions that are target revisions of a deployment
    /// group.
    ///
    /// * `exclude`: Do not list revisions that are target revisions of a
    /// deployment group.
    ///
    /// * `ignore`: List all revisions.
    deployed: ?ListStateFilterAction = null,

    /// An identifier returned from the previous `ListApplicationRevisions` call.
    /// It can be used to return the next set of applications in the list.
    next_token: ?[]const u8 = null,

    /// An Amazon S3 bucket name to limit the search for revisions.
    ///
    /// If set to null, all of the user's buckets are searched.
    s_3_bucket: ?[]const u8 = null,

    /// A key prefix for the set of Amazon S3 objects to limit the search for
    /// revisions.
    s_3_key_prefix: ?[]const u8 = null,

    /// The column name to use to sort the list results:
    ///
    /// * `registerTime`: Sort by the time the revisions were registered with
    /// CodeDeploy.
    ///
    /// * `firstUsedTime`: Sort by the time the revisions were first used in
    /// a deployment.
    ///
    /// * `lastUsedTime`: Sort by the time the revisions were last used in a
    /// deployment.
    ///
    /// If not specified or set to null, the results are returned in an arbitrary
    /// order.
    sort_by: ?ApplicationRevisionSortBy = null,

    /// The order in which to sort the list results:
    ///
    /// * `ascending`: ascending order.
    ///
    /// * `descending`: descending order.
    ///
    /// If not specified, the results are sorted in ascending order.
    ///
    /// If set to null, the results are sorted in an arbitrary order.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .deployed = "deployed",
        .next_token = "nextToken",
        .s_3_bucket = "s3Bucket",
        .s_3_key_prefix = "s3KeyPrefix",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListApplicationRevisionsOutput = struct {
    /// If a large amount of information is returned, an identifier is also
    /// returned. It can
    /// be used in a subsequent list application revisions call to return the next
    /// set of
    /// application revisions in the list.
    next_token: ?[]const u8 = null,

    /// A list of locations that contain the matching revisions.
    revisions: ?[]const RevisionLocation = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .revisions = "revisions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationRevisionsInput, options: CallOptions) !ListApplicationRevisionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationRevisionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListApplicationRevisions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationRevisionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListApplicationRevisionsOutput, body, allocator);
}
