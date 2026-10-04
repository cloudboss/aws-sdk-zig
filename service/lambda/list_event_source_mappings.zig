const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventSourceMappingConfiguration = @import("event_source_mapping_configuration.zig").EventSourceMappingConfiguration;

pub const ListEventSourceMappingsInput = struct {
    /// The Amazon Resource Name (ARN) of the event source.
    ///
    /// * **Amazon Kinesis** – The ARN of the data stream or a stream consumer.
    /// * **Amazon DynamoDB Streams** – The ARN of the stream.
    /// * **Amazon Simple Queue Service** – The ARN of the queue.
    /// * **Amazon Managed Streaming for Apache Kafka** – The ARN of the cluster or
    ///   the ARN of the VPC connection (for [cross-account event source
    ///   mappings](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#msk-multi-vpc)).
    /// * **Amazon MQ** – The ARN of the broker.
    /// * **Amazon DocumentDB** – The ARN of the DocumentDB change stream.
    event_source_arn: ?[]const u8 = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `MyFunction`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction`.
    /// * **Version or Alias ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:MyFunction:PROD`.
    /// * **Partial ARN** – `123456789012:function:MyFunction`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it's limited to 64 characters in length.
    function_name: ?[]const u8 = null,

    /// A pagination token returned by a previous call.
    marker: ?[]const u8 = null,

    /// The maximum number of event source mappings to return. Note that
    /// ListEventSourceMappings returns a maximum of 100 items in each response,
    /// even if you set the number higher.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .event_source_arn = "EventSourceArn",
        .function_name = "FunctionName",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const ListEventSourceMappingsOutput = struct {
    /// A list of event source mappings.
    event_source_mappings: ?[]const EventSourceMappingConfiguration = null,

    /// A pagination token that's returned when the response doesn't contain all
    /// event source mappings.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_source_mappings = "EventSourceMappings",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEventSourceMappingsInput, options: CallOptions) !ListEventSourceMappingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEventSourceMappingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-03-31/event-source-mappings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.event_source_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EventSourceArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.function_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "FunctionName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEventSourceMappingsOutput {
    const result: ListEventSourceMappingsOutput = try aws.json.parseJsonObject(
        ListEventSourceMappingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
