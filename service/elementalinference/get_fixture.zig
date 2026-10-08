const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Competitor = @import("competitor.zig").Competitor;

pub const GetFixtureInput = struct {
    /// The ID of the fixture to retrieve, as returned by SearchFixtures.
    fixture_id: []const u8,

    pub const json_field_names = .{
        .fixture_id = "fixtureId",
    };
};

pub const GetFixtureOutput = struct {
    /// An array of the competitors (the teams or individuals) in the fixture.
    competitors: ?[]const Competitor = null,

    /// The group that the fixture belongs to, such as the competition, league, or
    /// tournament. The data source doesn't provide this information for every
    /// fixture.
    fixture_group: ?[]const u8 = null,

    /// The ID that you specified in the request.
    fixture_id: []const u8,

    /// The name of the fixture, as provided by the data source. For example, the
    /// names of the two competing teams.
    name: []const u8,

    /// The scheduled start time of the fixture, as provided by the data source. The
    /// actual start time might differ.
    scheduled_start: ?i64 = null,

    /// The status of the fixture in its lifecycle, as provided by the data source.
    /// For example, Scheduled or Completed.
    status: []const u8,

    pub const json_field_names = .{
        .competitors = "competitors",
        .fixture_group = "fixtureGroup",
        .fixture_id = "fixtureId",
        .name = "name",
        .scheduled_start = "scheduledStart",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFixtureInput, options: CallOptions) !GetFixtureOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFixtureInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/fixtures/");
    try path_buf.appendSlice(allocator, input.fixture_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFixtureOutput {
    const result: GetFixtureOutput = try aws.json.parseJsonObject(
        GetFixtureOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
