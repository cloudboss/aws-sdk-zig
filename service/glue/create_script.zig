const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeGenEdge = @import("code_gen_edge.zig").CodeGenEdge;
const CodeGenNode = @import("code_gen_node.zig").CodeGenNode;
const Language = @import("language.zig").Language;

pub const CreateScriptInput = struct {
    /// A list of the edges in the DAG.
    dag_edges: ?[]const CodeGenEdge = null,

    /// A list of the nodes in the DAG.
    dag_nodes: ?[]const CodeGenNode = null,

    /// The programming language of the resulting code from the DAG.
    language: ?Language = null,

    pub const json_field_names = .{
        .dag_edges = "DagEdges",
        .dag_nodes = "DagNodes",
        .language = "Language",
    };
};

pub const CreateScriptOutput = struct {
    /// The Python script generated from the DAG.
    python_script: ?[]const u8 = null,

    /// The Scala code generated from the DAG.
    scala_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .python_script = "PythonScript",
        .scala_code = "ScalaCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScriptInput, options: CallOptions) !CreateScriptOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScriptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateScript");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScriptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateScriptOutput, body, allocator);
}
