const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterVersionStatus = @import("cluster_version_status.zig").ClusterVersionStatus;
const VersionStatus = @import("version_status.zig").VersionStatus;
const ClusterVersionInformation = @import("cluster_version_information.zig").ClusterVersionInformation;

pub const DescribeClusterVersionsInput = struct {
    /// The type of cluster to filter versions by.
    cluster_type: ?[]const u8 = null,

    /// List of specific cluster versions to describe.
    cluster_versions: ?[]const []const u8 = null,

    /// Filter to show only default versions.
    default_only: ?bool = null,

    /// Include all available versions in the response.
    include_all: ?bool = null,

    /// Maximum number of results to return.
    max_results: ?i32 = null,

    /// Pagination token for the next set of results.
    next_token: ?[]const u8 = null,

    /// This field is deprecated. Use `versionStatus` instead, as that field
    /// matches for input and output of this action.
    ///
    /// Filter versions by their current status.
    status: ?ClusterVersionStatus = null,

    /// Filter versions by their current status.
    version_status: ?VersionStatus = null,

    pub const json_field_names = .{
        .cluster_type = "clusterType",
        .cluster_versions = "clusterVersions",
        .default_only = "defaultOnly",
        .include_all = "includeAll",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
        .version_status = "versionStatus",
    };
};

pub const DescribeClusterVersionsOutput = struct {
    /// List of cluster version information objects.
    cluster_versions: ?[]const ClusterVersionInformation = null,

    /// Pagination token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_versions = "clusterVersions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterVersionsInput, options: CallOptions) !DescribeClusterVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cluster-versions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cluster_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.cluster_versions) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "clusterVersions=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.default_only) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "defaultOnly=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.include_all) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeAll=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.version_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterVersionsOutput {
    var result: DescribeClusterVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeClusterVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
