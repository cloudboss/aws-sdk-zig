const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLanguageVersion = @import("query_language_version.zig").QueryLanguageVersion;

pub const GetEngineStatusInput = struct {};

pub const GetEngineStatusOutput = struct {
    /// Set to the Neptune engine version running on your DB cluster. If this engine
    /// version has been manually patched since it was released, the version number
    /// is prefixed by `Patch-`.
    db_engine_version: ?[]const u8 = null,

    /// Set to `enabled` if the DFE engine is fully enabled, or to `viaQueryHint`
    /// (the default) if the DFE engine is only used with queries that have the
    /// `useDFE` query hint set to `true`.
    dfe_query_engine: ?[]const u8 = null,

    /// Contains status information about the features enabled on your DB cluster.
    features: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the Gremlin query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current TinkerPop version being used by the engine.
    gremlin: ?QueryLanguageVersion = null,

    /// Contains Lab Mode settings being used by the engine.
    lab_mode: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the openCypher query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current operCypher version being used by the engine.
    opencypher: ?QueryLanguageVersion = null,

    /// Set to `reader` if the instance is a read-replica, or to `writer` if the
    /// instance is the primary instance.
    role: ?[]const u8 = null,

    /// If there are transactions being rolled back, this field is set to the number
    /// of such transactions. If there are none, the field doesn't appear at all.
    rolling_back_trx_count: ?i32 = null,

    /// Set to the start time of the earliest transaction being rolled back. If no
    /// transactions are being rolled back, the field doesn't appear at all.
    rolling_back_trx_earliest_start_time: ?[]const u8 = null,

    /// Contains information about the current settings on your DB cluster. For
    /// example, contains the current cluster query timeout setting
    /// (`clusterQueryTimeoutInMs`).
    settings: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the SPARQL query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current SPARQL version being used by the engine.
    sparql: ?QueryLanguageVersion = null,

    /// Set to the UTC time at which the current server process started.
    start_time: ?[]const u8 = null,

    /// Set to `healthy` if the instance is not experiencing problems. If the
    /// instance is recovering from a crash or from being rebooted and there are
    /// active transactions running from the latest server shutdown, status is set
    /// to `recovery`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_engine_version = "dbEngineVersion",
        .dfe_query_engine = "dfeQueryEngine",
        .features = "features",
        .gremlin = "gremlin",
        .lab_mode = "labMode",
        .opencypher = "opencypher",
        .role = "role",
        .rolling_back_trx_count = "rollingBackTrxCount",
        .rolling_back_trx_earliest_start_time = "rollingBackTrxEarliestStartTime",
        .settings = "settings",
        .sparql = "sparql",
        .start_time = "startTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEngineStatusInput, options: CallOptions) !GetEngineStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEngineStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/status";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEngineStatusOutput {
    var result: GetEngineStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEngineStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
