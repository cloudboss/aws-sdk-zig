const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexState = @import("index_state.zig").IndexState;
const IndexType = @import("index_type.zig").IndexType;

pub const GetIndexInput = struct {};

pub const GetIndexOutput = struct {
    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the index.
    arn: ?[]const u8 = null,

    /// The date and time when the index was originally created.
    created_at: ?i64 = null,

    /// The date and time when the index was last updated.
    last_updated_at: ?i64 = null,

    /// This response value is present only if this index is `Type=AGGREGATOR`.
    ///
    /// A list of the Amazon Web Services Regions that replicate their content to
    /// the index in this Region.
    replicating_from: ?[]const []const u8 = null,

    /// This response value is present only if this index is `Type=LOCAL`.
    ///
    /// The Amazon Web Services Region that contains the aggregator index, if one
    /// exists. If an aggregator index does exist then the Region in which you
    /// called this operation replicates its index information to the Region
    /// specified in this response value.
    replicating_to: ?[]const []const u8 = null,

    /// The current state of the index in this Amazon Web Services Region.
    state: ?IndexState = null,

    /// Tag key and value pairs that are attached to the index.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the index in this Region. For information about the aggregator
    /// index and how it differs from a local index, see [Turning on cross-Region
    /// search by creating an aggregator
    /// index](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-aggregator-region.html).
    type: ?IndexType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .replicating_from = "ReplicatingFrom",
        .replicating_to = "ReplicatingTo",
        .state = "State",
        .tags = "Tags",
        .type = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIndexInput, options: CallOptions) !GetIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIndexInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetIndex";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIndexOutput {
    const result: GetIndexOutput = try aws.json.parseJsonObject(
        GetIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
