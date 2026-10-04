const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentFormat = @import("component_format.zig").ComponentFormat;
const Platform = @import("platform.zig").Platform;
const ComponentType = @import("component_type.zig").ComponentType;

pub const ImportComponentInput = struct {
    /// The change description of the component. This description indicates the
    /// change that
    /// has been made in this version, or what makes this version different from
    /// other versions
    /// of the component.
    change_description: ?[]const u8 = null,

    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// The data of the component. For the `SHELL` format, this is the
    /// plain script content. You must specify exactly one of the `data`
    /// or `uri` properties. For scripts that exceed the inline length
    /// constraint, use the `uri` property.
    data: ?[]const u8 = null,

    /// The description of the component. Describes the contents of the component.
    description: ?[]const u8 = null,

    /// The format of the resource that you want to import as a component.
    format: ComponentFormat,

    /// The Amazon Resource Name (ARN) of the KMS key that is used to encrypt this
    /// component.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*. If you don't specify a key,
    /// Image Builder encrypts the
    /// component data with a KMS key that Image Builder owns.
    kms_key_id: ?[]const u8 = null,

    /// The name of the component. Image Builder generates the component ARN from a
    /// normalized form of the name, so names that differ only in case, spaces, or
    /// underscores count as the same name. If a component with the same name and
    /// semantic version already exists in your account in the same Amazon Web
    /// Services Region,
    /// the request creates a new build version for it. If the content is also
    /// identical to the latest build version, the request fails because the
    /// component already exists.
    name: []const u8,

    /// The platform of the component.
    platform: Platform,

    /// The semantic version of the component. This version follows the semantic
    /// version
    /// syntax.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Assignment:** For the first three nodes, you can assign any positive
    /// integer value, including
    /// zero. The upper limit is 2^30-1, or 1073741823, for each node. Image Builder
    /// automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    semantic_version: []const u8,

    /// The tags of the component.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the component denotes whether the component is used to build the
    /// image, or
    /// only to test it.
    @"type": ComponentType,

    /// The uri of the component. Must be an Amazon S3 URL and you must have
    /// permission
    /// to access the Amazon S3 bucket. If you use Amazon S3, you can specify
    /// component content up to your
    /// service quota. Either `data` or `uri` can be used to specify the
    /// data within the component.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_description = "changeDescription",
        .client_token = "clientToken",
        .data = "data",
        .description = "description",
        .format = "format",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .platform = "platform",
        .semantic_version = "semanticVersion",
        .tags = "tags",
        .@"type" = "type",
        .uri = "uri",
    };
};

pub const ImportComponentOutput = struct {
    /// The client token that uniquely identifies the request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the imported component.
    component_build_version_arn: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .component_build_version_arn = "componentBuildVersionArn",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportComponentInput, options: CallOptions) !ImportComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ImportComponent";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.change_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"changeDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"data\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"format\":");
    try aws.json.writeValue(@TypeOf(input.format), input.format, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"platform\":");
    try aws.json.writeValue(@TypeOf(input.platform), input.platform, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"semanticVersion\":");
    try aws.json.writeValue(@TypeOf(input.semantic_version), input.semantic_version, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (input.uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"uri\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportComponentOutput {
    const result: ImportComponentOutput = try aws.json.parseJsonObject(
        ImportComponentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
