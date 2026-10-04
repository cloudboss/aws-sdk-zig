const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputFormat = @import("input_format.zig").InputFormat;
const FormatOptions = @import("format_options.zig").FormatOptions;
const Input = @import("input.zig").Input;
const PathOptions = @import("path_options.zig").PathOptions;
const Source = @import("source.zig").Source;

pub const DescribeDatasetInput = struct {
    /// The name of the dataset to be described.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeDatasetOutput = struct {
    /// The date and time that the dataset was created.
    create_date: ?i64 = null,

    /// The identifier (user name) of the user who created the dataset.
    created_by: ?[]const u8 = null,

    /// The file format of a dataset that is created from an Amazon S3 file
    /// or folder.
    format: ?InputFormat = null,

    format_options: ?FormatOptions = null,

    input: ?Input = null,

    /// The identifier (user name) of the user who last modified the dataset.
    last_modified_by: ?[]const u8 = null,

    /// The date and time that the dataset was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the dataset.
    name: []const u8,

    /// A set of options that defines how DataBrew interprets an Amazon S3
    /// path of the dataset.
    path_options: ?PathOptions = null,

    /// The Amazon Resource Name (ARN) of the dataset.
    resource_arn: ?[]const u8 = null,

    /// The location of the data for this dataset, Amazon S3 or the
    /// Glue Data Catalog.
    source: ?Source = null,

    /// Metadata tags associated with this dataset.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .format = "Format",
        .format_options = "FormatOptions",
        .input = "Input",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .path_options = "PathOptions",
        .resource_arn = "ResourceArn",
        .source = "Source",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetInput, options: CallOptions) !DescribeDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetOutput {
    var result: DescribeDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
