const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageLoggingConfiguration = @import("image_logging_configuration.zig").ImageLoggingConfiguration;

pub const DistributeImageInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the distribution configuration. The
    /// configuration
    /// defines target Regions, accounts, and AMI settings. The distribution
    /// configuration must be in the same Region as this operation.
    distribution_configuration_arn: []const u8,

    /// The name or Amazon Resource Name (ARN) of the IAM role that Image Builder
    /// assumes to distribute
    /// the image.
    execution_role: []const u8,

    /// The logging configuration for the distribution.
    logging_configuration: ?ImageLoggingConfiguration = null,

    /// The source image to distribute. You can specify the source in any of the
    /// following formats:
    ///
    /// * An AMI ID.
    ///
    /// * An Amazon Web Services Systems Manager Parameter Store reference, prefixed
    ///   by
    /// `ssm:`, followed by the parameter name or ARN.
    ///
    /// * An Image Builder image Amazon Resource Name (ARN). An image version ARN
    ///   resolves to the latest
    /// available build version.
    ///
    /// Whichever format you use, the source must resolve to an AMI in the current
    /// Amazon Web Services Region.
    source_image: []const u8,

    /// The tags to apply to the new Image Builder image resource that this
    /// operation
    /// creates. To tag the output AMIs, use `amiTags` in the
    /// distribution configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .distribution_configuration_arn = "distributionConfigurationArn",
        .execution_role = "executionRole",
        .logging_configuration = "loggingConfiguration",
        .source_image = "sourceImage",
        .tags = "tags",
    };
};

pub const DistributeImageOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the new Image Builder image resource that
    /// this operation creates to
    /// track the distribution. Use this ARN with GetImage to
    /// monitor distribution progress.
    image_build_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .image_build_version_arn = "imageBuildVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DistributeImageInput, options: CallOptions) !DistributeImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DistributeImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DistributeImage";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"distributionConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.distribution_configuration_arn), input.distribution_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRole\":");
    try aws.json.writeValue(@TypeOf(input.execution_role), input.execution_role, allocator, &body_buf);
    has_prev = true;
    if (input.logging_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"loggingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceImage\":");
    try aws.json.writeValue(@TypeOf(input.source_image), input.source_image, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DistributeImageOutput {
    const result: DistributeImageOutput = try aws.json.parseJsonObject(
        DistributeImageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
