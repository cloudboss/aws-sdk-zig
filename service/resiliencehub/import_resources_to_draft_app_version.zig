const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EksSource = @import("eks_source.zig").EksSource;
const ResourceImportStrategyType = @import("resource_import_strategy_type.zig").ResourceImportStrategyType;
const TerraformSource = @import("terraform_source.zig").TerraformSource;
const ResourceImportStatusType = @import("resource_import_status_type.zig").ResourceImportStatusType;

pub const ImportResourcesToDraftAppVersionInput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// The input sources of the Amazon Elastic Kubernetes Service resources you
    /// need to import.
    eks_sources: ?[]const EksSource = null,

    /// The import strategy you would like to set to import resources into
    /// Resilience Hub
    /// application.
    import_strategy: ?ResourceImportStrategyType = null,

    /// The Amazon Resource Names (ARNs) for the resources.
    source_arns: ?[]const []const u8 = null,

    /// A list of terraform file s3 URLs you need to import.
    terraform_sources: ?[]const TerraformSource = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .eks_sources = "eksSources",
        .import_strategy = "importStrategy",
        .source_arns = "sourceArns",
        .terraform_sources = "terraformSources",
    };
};

pub const ImportResourcesToDraftAppVersionOutput = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: []const u8,

    /// The version of the application.
    app_version: []const u8,

    /// The input sources of the Amazon Elastic Kubernetes Service resources you
    /// have imported.
    eks_sources: ?[]const EksSource = null,

    /// The Amazon Resource Names (ARNs) for the resources you have imported.
    source_arns: ?[]const []const u8 = null,

    /// Status of the action.
    status: ResourceImportStatusType,

    /// A list of terraform file s3 URLs you have imported.
    terraform_sources: ?[]const TerraformSource = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_version = "appVersion",
        .eks_sources = "eksSources",
        .source_arns = "sourceArns",
        .status = "status",
        .terraform_sources = "terraformSources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportResourcesToDraftAppVersionInput, options: CallOptions) !ImportResourcesToDraftAppVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportResourcesToDraftAppVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/import-resources-to-draft-app-version";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appArn\":");
    try aws.json.writeValue(@TypeOf(input.app_arn), input.app_arn, allocator, &body_buf);
    has_prev = true;
    if (input.eks_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eksSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.import_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"importStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.terraform_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"terraformSources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportResourcesToDraftAppVersionOutput {
    var result: ImportResourcesToDraftAppVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportResourcesToDraftAppVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
