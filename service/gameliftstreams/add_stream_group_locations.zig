const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocationConfiguration = @import("location_configuration.zig").LocationConfiguration;
const LocationState = @import("location_state.zig").LocationState;

pub const AddStreamGroupLocationsInput = struct {
    /// A stream group to add the specified locations to.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// A set of one or more locations and the streaming capacity for each location.
    location_configurations: []const LocationConfiguration,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .location_configurations = "LocationConfigurations",
    };
};

pub const AddStreamGroupLocationsOutput = struct {
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// This value is set of locations, including their name, current status, and
    /// capacities.
    ///
    /// A location can be in one of the following states:
    ///
    /// * `ACTIVATING`: Amazon GameLift Streams is preparing the location. You
    ///   cannot stream from, scale the capacity of, or remove this location yet.
    /// * `ACTIVE`: The location is provisioned with initial capacity. You can now
    ///   stream from, scale the capacity of, or remove this location.
    /// * `ERROR`: Amazon GameLift Streams failed to set up this location. The
    ///   `StatusReason` field describes the error. You can remove this location and
    ///   try to add it again.
    /// * `REMOVING`: Amazon GameLift Streams is working to remove this location.
    ///   This will release all provisioned capacity for this location in this
    ///   stream group.
    locations: ?[]const LocationState = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .locations = "Locations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddStreamGroupLocationsInput, options: CallOptions) !AddStreamGroupLocationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddStreamGroupLocationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/locations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LocationConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.location_configurations), input.location_configurations, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddStreamGroupLocationsOutput {
    var result: AddStreamGroupLocationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddStreamGroupLocationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
