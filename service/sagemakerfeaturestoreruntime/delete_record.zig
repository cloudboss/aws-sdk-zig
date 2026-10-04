const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionMode = @import("deletion_mode.zig").DeletionMode;
const TargetStore = @import("target_store.zig").TargetStore;

pub const DeleteRecordInput = struct {
    /// The name of the deletion mode for deleting the record. By default, the
    /// deletion mode is
    /// set to `SoftDelete`.
    deletion_mode: ?DeletionMode = null,

    /// Timestamp indicating when the deletion event occurred. `EventTime` can be
    /// used to query data at a certain point in time.
    event_time: []const u8,

    /// The name or Amazon Resource Name (ARN) of the feature group to delete the
    /// record from.
    feature_group_name: []const u8,

    /// The value for the `RecordIdentifier` that uniquely identifies the record, in
    /// string format.
    record_identifier_value_as_string: []const u8,

    /// A list of stores from which you're deleting the record. By default, Feature
    /// Store
    /// deletes the record from all of the stores that you're using for the
    /// `FeatureGroup`.
    target_stores: ?[]const TargetStore = null,

    pub const json_field_names = .{
        .deletion_mode = "DeletionMode",
        .event_time = "EventTime",
        .feature_group_name = "FeatureGroupName",
        .record_identifier_value_as_string = "RecordIdentifierValueAsString",
        .target_stores = "TargetStores",
    };
};

pub const DeleteRecordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRecordInput, options: CallOptions) !DeleteRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("featurestore-runtime.sagemaker", "SageMaker FeatureStore Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.deletion_mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "DeletionMode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "EventTime=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.event_time);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "RecordIdentifierValueAsString=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.record_identifier_value_as_string);
    query_has_prev = true;
    if (input.target_stores) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "TargetStores=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRecordOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteRecordOutput = .{};

    return result;
}
