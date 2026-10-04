const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Suggester = @import("suggester.zig").Suggester;
const SuggesterStatus = @import("suggester_status.zig").SuggesterStatus;
const serde = @import("serde.zig");

pub const DefineSuggesterInput = struct {
    domain_name: []const u8,

    suggester: Suggester,
};

pub const DefineSuggesterOutput = struct {
    suggester: ?SuggesterStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DefineSuggesterInput, options: CallOptions) !DefineSuggesterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudsearch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DefineSuggesterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DefineSuggester&Version=2013-01-01");
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);
    if (input.suggester.document_suggester_options.fuzzy_matching) |sv2| {
        try body_buf.appendSlice(allocator, "&Suggester.DocumentSuggesterOptions.FuzzyMatching=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
    }
    if (input.suggester.document_suggester_options.sort_expression) |sv2| {
        try body_buf.appendSlice(allocator, "&Suggester.DocumentSuggesterOptions.SortExpression=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
    }
    try body_buf.appendSlice(allocator, "&Suggester.DocumentSuggesterOptions.SourceField=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.suggester.document_suggester_options.source_field);
    try body_buf.appendSlice(allocator, "&Suggester.SuggesterName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.suggester.suggester_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DefineSuggesterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefineSuggesterResult")) break;
            },
            else => {},
        }
    }

    var result: DefineSuggesterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Suggester")) {
                    result.suggester = try serde.deserializeSuggesterStatus(allocator, &reader);
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
