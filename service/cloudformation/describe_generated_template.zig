const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateProgress = @import("template_progress.zig").TemplateProgress;
const ResourceDetail = @import("resource_detail.zig").ResourceDetail;
const GeneratedTemplateStatus = @import("generated_template_status.zig").GeneratedTemplateStatus;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;
const serde = @import("serde.zig");

pub const DescribeGeneratedTemplateInput = struct {
    /// The name or Amazon Resource Name (ARN) of a generated template.
    generated_template_name: []const u8,
};

pub const DescribeGeneratedTemplateOutput = struct {
    /// The time the generated template was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the generated template. The format is
    /// `arn:${Partition}:cloudformation:${Region}:${Account}:generatedtemplate/${Id}`.
    /// For example,
    /// `arn:aws:cloudformation:*us-east-1*:*123456789012*:generatedtemplate/*2e8465c1-9a80-43ea-a3a3-4f2d692fe6dc*
    /// `.
    generated_template_id: ?[]const u8 = null,

    /// The name of the generated template.
    generated_template_name: ?[]const u8 = null,

    /// The time the generated template was last updated.
    last_updated_time: ?i64 = null,

    /// An object describing the progress of the template generation.
    progress: ?TemplateProgress = null,

    /// A list of objects describing the details of the resources in the template
    /// generation.
    resources: ?[]const ResourceDetail = null,

    /// The stack ARN of the base stack if a base stack was provided when generating
    /// the
    /// template.
    stack_id: ?[]const u8 = null,

    /// The status of the template generation. Supported values are:
    ///
    /// * `CreatePending` - the creation of the template is pending.
    ///
    /// * `CreateInProgress` - the creation of the template is in progress.
    ///
    /// * `DeletePending` - the deletion of the template is pending.
    ///
    /// * `DeleteInProgress` - the deletion of the template is in progress.
    ///
    /// * `UpdatePending` - the update of the template is pending.
    ///
    /// * `UpdateInProgress` - the update of the template is in progress.
    ///
    /// * `Failed` - the template operation failed.
    ///
    /// * `Complete` - the template operation is complete.
    status: ?GeneratedTemplateStatus = null,

    /// The reason for the current template generation status. This will provide
    /// more details if a
    /// failure happened.
    status_reason: ?[]const u8 = null,

    /// The configuration details of the generated template, including the
    /// `DeletionPolicy` and `UpdateReplacePolicy`.
    template_configuration: ?TemplateConfiguration = null,

    /// The number of warnings generated for this template. The warnings are found
    /// in the details
    /// of each of the resources in the template.
    total_warnings: ?i32 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGeneratedTemplateInput, options: CallOptions) !DescribeGeneratedTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGeneratedTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeGeneratedTemplate&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&GeneratedTemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.generated_template_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGeneratedTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeGeneratedTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeGeneratedTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "GeneratedTemplateId")) {
                    result.generated_template_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeneratedTemplateName")) {
                    result.generated_template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Progress")) {
                    result.progress = try serde.deserializeTemplateProgress(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try serde.deserializeResourceDetails(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = GeneratedTemplateStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateConfiguration")) {
                    result.template_configuration = try serde.deserializeTemplateConfiguration(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "TotalWarnings")) {
                    result.total_warnings = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
