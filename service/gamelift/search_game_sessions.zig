const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameSession = @import("game_session.zig").GameSession;

pub const SearchGameSessionsInput = struct {
    /// A unique identifier for the alias associated with the fleet to search for
    /// active game sessions. You can use either
    /// the alias ID or ARN value. Each request must reference either a fleet ID or
    /// alias ID,
    /// but not both.
    alias_id: ?[]const u8 = null,

    /// String containing the search criteria for the session search. If no filter
    /// expression
    /// is included, the request returns results for all game sessions in the fleet
    /// that are in
    /// `ACTIVE` status.
    ///
    /// A filter expression can contain one or multiple conditions. Each condition
    /// consists of
    /// the following:
    ///
    /// * **Operand** -- Name of a game session attribute.
    /// Valid values are `gameSessionName`, `gameSessionId`,
    /// `gameSessionProperties`, `maximumSessions`,
    /// `creationTimeMillis`, `playerSessionCount`,
    /// `hasAvailablePlayerSessions`.
    ///
    /// * **Comparator** -- Valid comparators are:
    /// `=`, `<>`, ``,
    /// `=`.
    ///
    /// * **Value** -- Value to be searched for. Values may
    /// be numbers, boolean values (true/false) or strings depending on the operand.
    /// String values are case sensitive and must be enclosed in single quotes.
    /// Special
    /// characters must be escaped. Boolean and string values can only be used with
    /// the
    /// comparators `=` and `<>`. For example, the following
    /// filter expression searches on `gameSessionName`:
    /// "`FilterExpression": "gameSessionName = 'Matt\\'s Awesome Game
    /// 1'"`.
    ///
    /// To chain multiple conditions in a single expression, use the logical
    /// keywords
    /// `AND`, `OR`, and `NOT` and parentheses as needed.
    /// For example: `x AND y AND NOT z`, `NOT (x OR y)`.
    ///
    /// Session search evaluates conditions from left to right using the following
    /// precedence
    /// rules:
    ///
    /// * `=`, `<>`, ``,
    /// `=`
    ///
    /// * Parentheses
    ///
    /// * NOT
    ///
    /// * AND
    ///
    /// * OR
    ///
    /// For example, this filter expression retrieves game sessions hosting at least
    /// ten
    /// players that have an open player slot: `"maximumSessions>=10 AND
    /// hasAvailablePlayerSessions=true"`.
    filter_expression: ?[]const u8 = null,

    /// A unique identifier for the fleet to search for active game sessions. You
    /// can use either the fleet ID or ARN
    /// value. Each request must reference either a fleet ID or alias ID, but not
    /// both.
    fleet_id: ?[]const u8 = null,

    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages. The maximum number of results
    /// returned is 20, even if this value is not set or
    /// is set higher than 20.
    limit: ?i32 = null,

    /// A fleet location to search for game sessions. You can specify a fleet's home
    /// Region or
    /// a remote location. Use the Amazon Web Services Region code format, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// Instructions on how to sort the search results. If no sort expression is
    /// included, the
    /// request returns results in random order. A sort expression consists of the
    /// following
    /// elements:
    ///
    /// * **Operand** -- Name of a game session attribute.
    /// Valid values are `gameSessionName`, `gameSessionId`,
    /// `gameSessionProperties`, `maximumSessions`,
    /// `creationTimeMillis`, `playerSessionCount`,
    /// `hasAvailablePlayerSessions`.
    ///
    /// * **Order** -- Valid sort orders are `ASC`
    /// (ascending) and `DESC` (descending).
    ///
    /// For example, this sort expression returns the oldest active sessions first:
    /// `"SortExpression": "creationTimeMillis ASC"`. Results with a null value
    /// for the sort operand are returned at the end of the list.
    sort_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .filter_expression = "FilterExpression",
        .fleet_id = "FleetId",
        .limit = "Limit",
        .location = "Location",
        .next_token = "NextToken",
        .sort_expression = "SortExpression",
    };
};

pub const SearchGameSessionsOutput = struct {
    /// A collection of objects containing game session properties for each session
    /// that
    /// matches the request.
    game_sessions: ?[]const GameSession = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_sessions = "GameSessions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchGameSessionsInput, options: CallOptions) !SearchGameSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchGameSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.SearchGameSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchGameSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchGameSessionsOutput, body, allocator);
}
