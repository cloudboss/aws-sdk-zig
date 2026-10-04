const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoteValue = @import("vote_value.zig").VoteValue;

pub const VoteOnProposalInput = struct {
    /// The unique identifier of the network.
    network_id: []const u8,

    /// The unique identifier of the proposal.
    proposal_id: []const u8,

    /// The value of the vote.
    vote: VoteValue,

    /// The unique identifier of the member casting the vote.
    voter_member_id: []const u8,

    pub const json_field_names = .{
        .network_id = "NetworkId",
        .proposal_id = "ProposalId",
        .vote = "Vote",
        .voter_member_id = "VoterMemberId",
    };
};

pub const VoteOnProposalOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VoteOnProposalInput, options: CallOptions) !VoteOnProposalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "managedblockchain", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: VoteOnProposalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("managedblockchain", "ManagedBlockchain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/proposals/");
    try path_buf.appendSlice(allocator, input.proposal_id);
    try path_buf.appendSlice(allocator, "/votes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Vote\":");
    try aws.json.writeValue(@TypeOf(input.vote), input.vote, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VoterMemberId\":");
    try aws.json.writeValue(@TypeOf(input.voter_member_id), input.voter_member_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VoteOnProposalOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: VoteOnProposalOutput = .{};

    return result;
}
