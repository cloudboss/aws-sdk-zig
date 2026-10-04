const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PodIdentityAssociationSummary = @import("pod_identity_association_summary.zig").PodIdentityAssociationSummary;

pub const ListPodIdentityAssociationsInput = struct {
    /// The name of the cluster that the associations are in.
    cluster_name: []const u8,

    /// The maximum number of EKS Pod Identity association results returned by
    /// `ListPodIdentityAssociations` in paginated output. When you use this
    /// parameter, `ListPodIdentityAssociations` returns only `maxResults`
    /// results in a single page along with a `nextToken` response element. You can
    /// see the remaining results of the initial request by sending another
    /// `ListPodIdentityAssociations` request with the returned
    /// `nextToken` value. This value can be between 1 and
    /// 100. If you don't use this parameter,
    /// `ListPodIdentityAssociations` returns up to 100 results
    /// and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The name of the Kubernetes namespace inside the cluster that the
    /// associations are in.
    namespace: ?[]const u8 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListUpdates` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The name of the Kubernetes service account that the associations use.
    service_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
        .service_account = "serviceAccount",
    };
};

pub const ListPodIdentityAssociationsOutput = struct {
    /// The list of summarized descriptions of the associations that are in the
    /// cluster and match
    /// any filters that you provided.
    ///
    /// Each summary is simplified by removing these fields compared to the full [
    /// `PodIdentityAssociation`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_PodIdentityAssociation.html):
    ///
    /// * The IAM role: `roleArn`
    ///
    /// * The timestamp that the association was created at: `createdAt`
    ///
    /// * The most recent timestamp that the association was modified at:.
    ///   `modifiedAt`
    ///
    /// * The tags on the association: `tags`
    associations: ?[]const PodIdentityAssociationSummary = null,

    /// The `nextToken` value to include in a future
    /// `ListPodIdentityAssociations` request. When the results of a
    /// `ListPodIdentityAssociations` request exceed `maxResults`, you
    /// can use this value to retrieve the next page of results. This value is
    /// `null`
    /// when there are no more results to return.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associations = "associations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPodIdentityAssociationsInput, options: CallOptions) !ListPodIdentityAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPodIdentityAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/pod-identity-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespace=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.service_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "serviceAccount=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPodIdentityAssociationsOutput {
    var result: ListPodIdentityAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPodIdentityAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
