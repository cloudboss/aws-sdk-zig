const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QualificationRequirement = @import("qualification_requirement.zig").QualificationRequirement;

pub const CreateHITTypeInput = struct {
    /// The amount of time, in seconds, that a Worker has to complete the HIT after
    /// accepting it.
    /// If a Worker does not complete the assignment within the specified duration,
    /// the assignment is considered abandoned. If the HIT is still active
    /// (that is, its lifetime has not elapsed), the assignment becomes available
    /// for other users to find and accept.
    assignment_duration_in_seconds: i64,

    /// The number of seconds after an assignment for the HIT has been submitted,
    /// after which the assignment is considered Approved automatically
    /// unless the Requester explicitly rejects it.
    auto_approval_delay_in_seconds: ?i64 = null,

    /// A general description of the HIT. A description includes detailed
    /// information about the kind of task
    /// the HIT contains. On the Amazon Mechanical Turk web site, the HIT
    /// description appears in the expanded
    /// view of search results, and in the HIT and assignment screens. A good
    /// description gives the user enough
    /// information to evaluate the HIT before accepting it.
    description: []const u8,

    /// One or more words or phrases that describe the HIT, separated by commas.
    /// These words are used in searches to find HITs.
    keywords: ?[]const u8 = null,

    /// Conditions that a Worker's Qualifications must meet in order
    /// to accept the HIT. A HIT can have between zero and ten
    /// Qualification requirements. All requirements must be met in
    /// order for a Worker to accept the HIT. Additionally, other
    /// actions can be restricted using the `ActionsGuarded`
    /// field on each `QualificationRequirement` structure.
    qualification_requirements: ?[]const QualificationRequirement = null,

    /// The amount of money the Requester will pay a Worker for successfully
    /// completing the HIT.
    reward: []const u8,

    /// The title of the HIT. A title should be short and descriptive about the kind
    /// of task the HIT contains.
    /// On the Amazon Mechanical Turk web site, the HIT title appears in search
    /// results,
    /// and everywhere the HIT is mentioned.
    title: []const u8,

    pub const json_field_names = .{
        .assignment_duration_in_seconds = "AssignmentDurationInSeconds",
        .auto_approval_delay_in_seconds = "AutoApprovalDelayInSeconds",
        .description = "Description",
        .keywords = "Keywords",
        .qualification_requirements = "QualificationRequirements",
        .reward = "Reward",
        .title = "Title",
    };
};

pub const CreateHITTypeOutput = struct {
    /// The ID of the newly registered HIT type.
    hit_type_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .hit_type_id = "HITTypeId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHITTypeInput, options: Options) !CreateHITTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mturk");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHITTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk", "MTurk", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.CreateHITType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHITTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHITTypeOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "RequestError")) {
        return .{ .arena = arena, .kind = .{ .request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFault")) {
        return .{ .arena = arena, .kind = .{ .service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
