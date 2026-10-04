const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LambdaFunctionRecipeSource = @import("lambda_function_recipe_source.zig").LambdaFunctionRecipeSource;
const CloudComponentStatus = @import("cloud_component_status.zig").CloudComponentStatus;

pub const CreateComponentVersionInput = struct {
    /// A unique, case-sensitive identifier that you can provide to ensure that the
    /// request is idempotent.
    /// Idempotency means that the request is successfully processed only once, even
    /// if you send the request multiple times.
    /// When a request succeeds, and you specify the same client token for
    /// subsequent successful requests, the IoT Greengrass V2 service
    /// returns the successful response that it caches from the previous request.
    /// IoT Greengrass V2 caches successful responses for
    /// idempotent requests for up to 8 hours.
    client_token: ?[]const u8 = null,

    /// The recipe to use to create the component. The recipe defines the
    /// component's metadata,
    /// parameters, dependencies, lifecycle, artifacts, and platform compatibility.
    ///
    /// You must specify either `inlineRecipe` or `lambdaFunction`.
    inline_recipe: ?[]const u8 = null,

    /// The parameters to create a component from a Lambda function.
    ///
    /// You must specify either `inlineRecipe` or `lambdaFunction`.
    lambda_function: ?LambdaFunctionRecipeSource = null,

    /// A list of key-value pairs that contain metadata for the resource. For more
    /// information, see [Tag your
    /// resources](https://docs.aws.amazon.com/greengrass/v2/developerguide/tag-resources.html) in the *IoT Greengrass V2 Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .inline_recipe = "inlineRecipe",
        .lambda_function = "lambdaFunction",
        .tags = "tags",
    };
};

pub const CreateComponentVersionOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8 = null,

    /// The name of the component.
    component_name: []const u8,

    /// The version of the component.
    component_version: []const u8,

    /// The time at which the component was created, expressed in ISO 8601 format.
    creation_timestamp: i64,

    /// The status of the component version in IoT Greengrass V2. This status
    /// is different from the status of the component on a core device.
    status: ?CloudComponentStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .component_name = "componentName",
        .component_version = "componentVersion",
        .creation_timestamp = "creationTimestamp",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComponentVersionInput, options: CallOptions) !CreateComponentVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComponentVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/v2/createComponentVersion";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inline_recipe) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inlineRecipe\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lambda_function) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lambdaFunction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComponentVersionOutput {
    var result: CreateComponentVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateComponentVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
