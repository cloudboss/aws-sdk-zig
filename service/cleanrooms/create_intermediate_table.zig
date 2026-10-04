const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PopulationAnalysisConfiguration = @import("population_analysis_configuration.zig").PopulationAnalysisConfiguration;
const IntermediateTable = @import("intermediate_table.zig").IntermediateTable;

pub const CreateIntermediateTableInput = struct {
    /// A description of the intermediate table.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the customer-managed KMS key used to
    /// encrypt the intermediate table data.
    kms_key_arn: ?[]const u8 = null,

    /// The unique identifier of the membership where the intermediate table is
    /// created.
    membership_identifier: []const u8,

    /// The display name for the intermediate table.
    name: []const u8,

    /// The configuration that defines the analysis used to populate the
    /// intermediate table.
    population_analysis_configuration: PopulationAnalysisConfiguration,

    /// The number of days to retain populated data versions.
    retention_in_days: ?i32 = null,

    /// An optional label that you can assign to a resource when you create it. Each
    /// tag consists of a key and an optional value, both of which you define. When
    /// you use tagging, you can also use tag-based access control in IAM policies
    /// to control access to this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .membership_identifier = "membershipIdentifier",
        .name = "name",
        .population_analysis_configuration = "populationAnalysisConfiguration",
        .retention_in_days = "retentionInDays",
        .tags = "tags",
    };
};

pub const CreateIntermediateTableOutput = struct {
    /// The intermediate table that was created.
    intermediate_table: ?IntermediateTable = null,

    pub const json_field_names = .{
        .intermediate_table = "intermediateTable",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntermediateTableInput, options: CallOptions) !CreateIntermediateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntermediateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/intermediateTables");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"populationAnalysisConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.population_analysis_configuration), input.population_analysis_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.retention_in_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retentionInDays\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntermediateTableOutput {
    const result: CreateIntermediateTableOutput = try aws.json.parseJsonObject(
        CreateIntermediateTableOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
