const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateStage = @import("template_stage.zig").TemplateStage;
const serde = @import("serde.zig");

pub const GetTemplateInput = struct {
    /// The name or Amazon Resource Name (ARN) of a change set for which
    /// CloudFormation returns the
    /// associated template. If you specify a name, you must also specify the
    /// `StackName`.
    change_set_name: ?[]const u8 = null,

    /// The name or the unique stack ID that's associated with the stack, which
    /// aren't always
    /// interchangeable:
    ///
    /// * Running stacks: You can specify either the stack's name or its unique
    ///   stack ID.
    ///
    /// * Deleted stacks: You must specify the unique stack ID.
    stack_name: ?[]const u8 = null,

    /// For templates that include transforms, the stage of the template that
    /// CloudFormation returns.
    /// To get the user-submitted template, specify `Original`. To get the template
    /// after
    /// CloudFormation has processed all transforms, specify `Processed`.
    ///
    /// If the template doesn't include transforms, `Original` and
    /// `Processed` return the same template. By default, CloudFormation specifies
    /// `Processed`.
    template_stage: ?TemplateStage = null,
};

pub const GetTemplateOutput = struct {
    /// The stage of the template that you can retrieve. For stacks, the `Original`
    /// and
    /// `Processed` templates are always available. For change sets, the
    /// `Original` template is always available. After CloudFormation finishes
    /// creating the
    /// change set, the `Processed` template becomes available.
    stages_available: ?[]const TemplateStage = null,

    /// Structure that contains the template body.
    ///
    /// CloudFormation returns the same template that was used when the stack was
    /// created.
    template_body: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateInput, options: CallOptions) !GetTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetTemplate&Version=2010-05-15");
    if (input.change_set_name) |v| {
        try body_buf.appendSlice(allocator, "&ChangeSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_stage) |v| {
        try body_buf.appendSlice(allocator, "&TemplateStage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: GetTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StagesAvailable")) {
                    result.stages_available = try serde.deserializeStageList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "TemplateBody")) {
                    result.template_body = try allocator.dupe(u8, try reader.readElementText());
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
