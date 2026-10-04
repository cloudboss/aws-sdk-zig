const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionCodeLocation = @import("function_code_location.zig").FunctionCodeLocation;
const Concurrency = @import("concurrency.zig").Concurrency;
const FunctionConfiguration = @import("function_configuration.zig").FunctionConfiguration;
const TagsError = @import("tags_error.zig").TagsError;

pub const GetFunctionInput = struct {
    /// The name or ARN of the Lambda function, version, or alias. **Name formats**
    ///
    /// * **Function name** – `my-function` (name-only), `my-function:v1` (with
    ///   alias).
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// You can append a version number or alias to any of the formats. The length
    /// constraint applies only to the full ARN. If you specify only the function
    /// name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Specify a version or alias to get details about a published version of the
    /// function.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .qualifier = "Qualifier",
    };
};

pub const GetFunctionOutput = struct {
    /// The deployment package of the function or version.
    code: ?FunctionCodeLocation = null,

    /// The function's [reserved
    /// concurrency](https://docs.aws.amazon.com/lambda/latest/dg/concurrent-executions.html).
    concurrency: ?Concurrency = null,

    /// The configuration of the function or version.
    configuration: ?FunctionConfiguration = null,

    /// The function's
    /// [tags](https://docs.aws.amazon.com/lambda/latest/dg/tagging.html). Lambda
    /// returns tag data only if you have explicit allow permissions for
    /// [lambda:ListTags](https://docs.aws.amazon.com/lambda/latest/api/API_ListTags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// An object that contains details about an error related to retrieving tags.
    tags_error: ?TagsError = null,

    pub const json_field_names = .{
        .code = "Code",
        .concurrency = "Concurrency",
        .configuration = "Configuration",
        .tags = "Tags",
        .tags_error = "TagsError",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFunctionInput, options: CallOptions) !GetFunctionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-03-31/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFunctionOutput {
    const result: GetFunctionOutput = try aws.json.parseJsonObject(
        GetFunctionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
