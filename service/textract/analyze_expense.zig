const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Document = @import("document.zig").Document;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const ExpenseDocument = @import("expense_document.zig").ExpenseDocument;

pub const AnalyzeExpenseInput = struct {
    document: Document,

    pub const json_field_names = .{
        .document = "Document",
    };
};

pub const AnalyzeExpenseOutput = struct {
    document_metadata: ?DocumentMetadata = null,

    /// The expenses detected by Amazon Textract.
    expense_documents: ?[]const ExpenseDocument = null,

    pub const json_field_names = .{
        .document_metadata = "DocumentMetadata",
        .expense_documents = "ExpenseDocuments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AnalyzeExpenseInput, options: CallOptions) !AnalyzeExpenseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AnalyzeExpenseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.AnalyzeExpense");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AnalyzeExpenseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AnalyzeExpenseOutput, body, allocator);
}
