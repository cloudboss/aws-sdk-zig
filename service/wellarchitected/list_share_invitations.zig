const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareResourceType = @import("share_resource_type.zig").ShareResourceType;
const ShareInvitationSummary = @import("share_invitation_summary.zig").ShareInvitationSummary;

pub const ListShareInvitationsInput = struct {
    /// An optional string added to the beginning of each lens name returned in the
    /// results.
    lens_name_prefix: ?[]const u8 = null,

    /// The maximum number of results to return for this request.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// An optional string added to the beginning of each profile name returned in
    /// the results.
    profile_name_prefix: ?[]const u8 = null,

    /// The type of share invitations to be returned.
    share_resource_type: ?ShareResourceType = null,

    /// An optional string added to the beginning of each review template name
    /// returned in the results.
    template_name_prefix: ?[]const u8 = null,

    workload_name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .lens_name_prefix = "LensNamePrefix",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .profile_name_prefix = "ProfileNamePrefix",
        .share_resource_type = "ShareResourceType",
        .template_name_prefix = "TemplateNamePrefix",
        .workload_name_prefix = "WorkloadNamePrefix",
    };
};

pub const ListShareInvitationsOutput = struct {
    next_token: ?[]const u8 = null,

    /// List of share invitation summaries in a workload.
    share_invitation_summaries: ?[]const ShareInvitationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .share_invitation_summaries = "ShareInvitationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListShareInvitationsInput, options: CallOptions) !ListShareInvitationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListShareInvitationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/shareInvitations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.lens_name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "LensNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.profile_name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ProfileNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.share_resource_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ShareResourceType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.template_name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "TemplateNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.workload_name_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "WorkloadNamePrefix=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListShareInvitationsOutput {
    const result: ListShareInvitationsOutput = try aws.json.parseJsonObject(
        ListShareInvitationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
