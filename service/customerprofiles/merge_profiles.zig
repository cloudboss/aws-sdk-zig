const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldSourceProfileIds = @import("field_source_profile_ids.zig").FieldSourceProfileIds;

pub const MergeProfilesInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The identifiers of the fields in the profile that has the information you
    /// want to apply
    /// to the merge. For example, say you want to merge EmailAddress from Profile1
    /// into
    /// MainProfile. This would be the identifier of the EmailAddress field in
    /// Profile1.
    field_source_profile_ids: ?FieldSourceProfileIds = null,

    /// The identifier of the profile to be taken.
    main_profile_id: []const u8,

    /// The identifier of the profile to be merged into MainProfileId.
    profile_ids_to_be_merged: []const []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .field_source_profile_ids = "FieldSourceProfileIds",
        .main_profile_id = "MainProfileId",
        .profile_ids_to_be_merged = "ProfileIdsToBeMerged",
    };
};

pub const MergeProfilesOutput = struct {
    /// A message that indicates the merge request is complete.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MergeProfilesInput, options: CallOptions) !MergeProfilesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MergeProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/profiles/objects/merge");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.field_source_profile_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FieldSourceProfileIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MainProfileId\":");
    try aws.json.writeValue(@TypeOf(input.main_profile_id), input.main_profile_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileIdsToBeMerged\":");
    try aws.json.writeValue(@TypeOf(input.profile_ids_to_be_merged), input.profile_ids_to_be_merged, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MergeProfilesOutput {
    const result: MergeProfilesOutput = try aws.json.parseJsonObject(
        MergeProfilesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
