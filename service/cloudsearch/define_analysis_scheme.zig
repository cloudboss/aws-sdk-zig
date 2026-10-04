const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisScheme = @import("analysis_scheme.zig").AnalysisScheme;
const AnalysisSchemeStatus = @import("analysis_scheme_status.zig").AnalysisSchemeStatus;
const serde = @import("serde.zig");

pub const DefineAnalysisSchemeInput = struct {
    analysis_scheme: AnalysisScheme,

    domain_name: []const u8,
};

pub const DefineAnalysisSchemeOutput = struct {
    analysis_scheme: ?AnalysisSchemeStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DefineAnalysisSchemeInput, options: CallOptions) !DefineAnalysisSchemeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DefineAnalysisSchemeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DefineAnalysisScheme&Version=2013-01-01");
    if (input.analysis_scheme.analysis_options) |sv| {
        if (sv.algorithmic_stemming) |sv2| {
            try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisOptions.AlgorithmicStemming=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
        }
        if (sv.japanese_tokenization_dictionary) |sv2| {
            try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisOptions.JapaneseTokenizationDictionary=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.stemming_dictionary) |sv2| {
            try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisOptions.StemmingDictionary=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.stopwords) |sv2| {
            try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisOptions.Stopwords=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.synonyms) |sv2| {
            try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisOptions.Synonyms=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisSchemeLanguage=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.analysis_scheme.analysis_scheme_language.wireName());
    try body_buf.appendSlice(allocator, "&AnalysisScheme.AnalysisSchemeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.analysis_scheme.analysis_scheme_name);
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DefineAnalysisSchemeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefineAnalysisSchemeResult")) break;
            },
            else => {},
        }
    }

    var result: DefineAnalysisSchemeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalysisScheme")) {
                    result.analysis_scheme = try serde.deserializeAnalysisSchemeStatus(allocator, &reader);
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
