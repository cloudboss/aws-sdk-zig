const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const OverrideStatus = @import("override_status.zig").OverrideStatus;

pub const OverridePullRequestApprovalRulesInput = struct {
    /// Whether you want to set aside approval rule requirements for the pull
    /// request (OVERRIDE) or revoke a previous override and apply
    /// approval rule requirements (REVOKE). REVOKE status is not stored.
    override_status: OverrideStatus,

    /// The system-generated ID of the pull request for which you want to override
    /// all
    /// approval rule requirements. To get this information, use
    /// GetPullRequest.
    pull_request_id: []const u8,

    /// The system-generated ID of the most recent revision of the pull request. You
    /// cannot override approval rules for anything but the most recent revision of
    /// a pull request.
    /// To get the revision ID, use GetPullRequest.
    revision_id: []const u8,

    pub const json_field_names = .{
        .override_status = "overrideStatus",
        .pull_request_id = "pullRequestId",
        .revision_id = "revisionId",
    };
};

pub const OverridePullRequestApprovalRulesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: OverridePullRequestApprovalRulesInput, options: CallOptions) !OverridePullRequestApprovalRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: OverridePullRequestApprovalRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.OverridePullRequestApprovalRules");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !OverridePullRequestApprovalRulesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "ActorDoesNotExistException")) {
        const parsed_error: ?errors.ActorDoesNotExistException = aws.json.parseJsonObject(errors.ActorDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .actor_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleContentRequiredException")) {
        const parsed_error: ?errors.ApprovalRuleContentRequiredException = aws.json.parseJsonObject(errors.ApprovalRuleContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleDoesNotExistException")) {
        const parsed_error: ?errors.ApprovalRuleDoesNotExistException = aws.json.parseJsonObject(errors.ApprovalRuleDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleNameAlreadyExistsException")) {
        const parsed_error: ?errors.ApprovalRuleNameAlreadyExistsException = aws.json.parseJsonObject(errors.ApprovalRuleNameAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_name_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleNameRequiredException")) {
        const parsed_error: ?errors.ApprovalRuleNameRequiredException = aws.json.parseJsonObject(errors.ApprovalRuleNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateContentRequiredException")) {
        const parsed_error: ?errors.ApprovalRuleTemplateContentRequiredException = aws.json.parseJsonObject(errors.ApprovalRuleTemplateContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_template_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateDoesNotExistException")) {
        const parsed_error: ?errors.ApprovalRuleTemplateDoesNotExistException = aws.json.parseJsonObject(errors.ApprovalRuleTemplateDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_template_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateInUseException")) {
        const parsed_error: ?errors.ApprovalRuleTemplateInUseException = aws.json.parseJsonObject(errors.ApprovalRuleTemplateInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_template_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateNameAlreadyExistsException")) {
        const parsed_error: ?errors.ApprovalRuleTemplateNameAlreadyExistsException = aws.json.parseJsonObject(errors.ApprovalRuleTemplateNameAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_template_name_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateNameRequiredException")) {
        const parsed_error: ?errors.ApprovalRuleTemplateNameRequiredException = aws.json.parseJsonObject(errors.ApprovalRuleTemplateNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_rule_template_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ApprovalStateRequiredException")) {
        const parsed_error: ?errors.ApprovalStateRequiredException = aws.json.parseJsonObject(errors.ApprovalStateRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .approval_state_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AuthorDoesNotExistException")) {
        const parsed_error: ?errors.AuthorDoesNotExistException = aws.json.parseJsonObject(errors.AuthorDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .author_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BeforeCommitIdAndAfterCommitIdAreSameException")) {
        const parsed_error: ?errors.BeforeCommitIdAndAfterCommitIdAreSameException = aws.json.parseJsonObject(errors.BeforeCommitIdAndAfterCommitIdAreSameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .before_commit_id_and_after_commit_id_are_same_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BlobIdDoesNotExistException")) {
        const parsed_error: ?errors.BlobIdDoesNotExistException = aws.json.parseJsonObject(errors.BlobIdDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .blob_id_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BlobIdRequiredException")) {
        const parsed_error: ?errors.BlobIdRequiredException = aws.json.parseJsonObject(errors.BlobIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .blob_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BranchDoesNotExistException")) {
        const parsed_error: ?errors.BranchDoesNotExistException = aws.json.parseJsonObject(errors.BranchDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .branch_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BranchNameExistsException")) {
        const parsed_error: ?errors.BranchNameExistsException = aws.json.parseJsonObject(errors.BranchNameExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .branch_name_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BranchNameIsTagNameException")) {
        const parsed_error: ?errors.BranchNameIsTagNameException = aws.json.parseJsonObject(errors.BranchNameIsTagNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .branch_name_is_tag_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BranchNameRequiredException")) {
        const parsed_error: ?errors.BranchNameRequiredException = aws.json.parseJsonObject(errors.BranchNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .branch_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteApprovalRuleFromTemplateException")) {
        const parsed_error: ?errors.CannotDeleteApprovalRuleFromTemplateException = aws.json.parseJsonObject(errors.CannotDeleteApprovalRuleFromTemplateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cannot_delete_approval_rule_from_template_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CannotModifyApprovalRuleFromTemplateException")) {
        const parsed_error: ?errors.CannotModifyApprovalRuleFromTemplateException = aws.json.parseJsonObject(errors.CannotModifyApprovalRuleFromTemplateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cannot_modify_approval_rule_from_template_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClientRequestTokenRequiredException")) {
        const parsed_error: ?errors.ClientRequestTokenRequiredException = aws.json.parseJsonObject(errors.ClientRequestTokenRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .client_request_token_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentContentRequiredException")) {
        const parsed_error: ?errors.CommentContentRequiredException = aws.json.parseJsonObject(errors.CommentContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentContentSizeLimitExceededException")) {
        const parsed_error: ?errors.CommentContentSizeLimitExceededException = aws.json.parseJsonObject(errors.CommentContentSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_content_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentDeletedException")) {
        const parsed_error: ?errors.CommentDeletedException = aws.json.parseJsonObject(errors.CommentDeletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_deleted_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentDoesNotExistException")) {
        const parsed_error: ?errors.CommentDoesNotExistException = aws.json.parseJsonObject(errors.CommentDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentIdRequiredException")) {
        const parsed_error: ?errors.CommentIdRequiredException = aws.json.parseJsonObject(errors.CommentIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommentNotCreatedByCallerException")) {
        const parsed_error: ?errors.CommentNotCreatedByCallerException = aws.json.parseJsonObject(errors.CommentNotCreatedByCallerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .comment_not_created_by_caller_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitDoesNotExistException")) {
        const parsed_error: ?errors.CommitDoesNotExistException = aws.json.parseJsonObject(errors.CommitDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitIdDoesNotExistException")) {
        const parsed_error: ?errors.CommitIdDoesNotExistException = aws.json.parseJsonObject(errors.CommitIdDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_id_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitIdRequiredException")) {
        const parsed_error: ?errors.CommitIdRequiredException = aws.json.parseJsonObject(errors.CommitIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitIdsLimitExceededException")) {
        const parsed_error: ?errors.CommitIdsLimitExceededException = aws.json.parseJsonObject(errors.CommitIdsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_ids_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitIdsListRequiredException")) {
        const parsed_error: ?errors.CommitIdsListRequiredException = aws.json.parseJsonObject(errors.CommitIdsListRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_ids_list_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitMessageLengthExceededException")) {
        const parsed_error: ?errors.CommitMessageLengthExceededException = aws.json.parseJsonObject(errors.CommitMessageLengthExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_message_length_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CommitRequiredException")) {
        const parsed_error: ?errors.CommitRequiredException = aws.json.parseJsonObject(errors.CommitRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .commit_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentReferenceUpdateException")) {
        const parsed_error: ?errors.ConcurrentReferenceUpdateException = aws.json.parseJsonObject(errors.ConcurrentReferenceUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_reference_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DefaultBranchCannotBeDeletedException")) {
        const parsed_error: ?errors.DefaultBranchCannotBeDeletedException = aws.json.parseJsonObject(errors.DefaultBranchCannotBeDeletedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_branch_cannot_be_deleted_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectoryNameConflictsWithFileNameException")) {
        const parsed_error: ?errors.DirectoryNameConflictsWithFileNameException = aws.json.parseJsonObject(errors.DirectoryNameConflictsWithFileNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .directory_name_conflicts_with_file_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionIntegrityChecksFailedException")) {
        const parsed_error: ?errors.EncryptionIntegrityChecksFailedException = aws.json.parseJsonObject(errors.EncryptionIntegrityChecksFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_integrity_checks_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyAccessDeniedException")) {
        const parsed_error: ?errors.EncryptionKeyAccessDeniedException = aws.json.parseJsonObject(errors.EncryptionKeyAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyDisabledException")) {
        const parsed_error: ?errors.EncryptionKeyDisabledException = aws.json.parseJsonObject(errors.EncryptionKeyDisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyInvalidIdException")) {
        const parsed_error: ?errors.EncryptionKeyInvalidIdException = aws.json.parseJsonObject(errors.EncryptionKeyInvalidIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_invalid_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyInvalidUsageException")) {
        const parsed_error: ?errors.EncryptionKeyInvalidUsageException = aws.json.parseJsonObject(errors.EncryptionKeyInvalidUsageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_invalid_usage_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyNotFoundException")) {
        const parsed_error: ?errors.EncryptionKeyNotFoundException = aws.json.parseJsonObject(errors.EncryptionKeyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyRequiredException")) {
        const parsed_error: ?errors.EncryptionKeyRequiredException = aws.json.parseJsonObject(errors.EncryptionKeyRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyUnavailableException")) {
        const parsed_error: ?errors.EncryptionKeyUnavailableException = aws.json.parseJsonObject(errors.EncryptionKeyUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .encryption_key_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileContentAndSourceFileSpecifiedException")) {
        const parsed_error: ?errors.FileContentAndSourceFileSpecifiedException = aws.json.parseJsonObject(errors.FileContentAndSourceFileSpecifiedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_content_and_source_file_specified_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileContentRequiredException")) {
        const parsed_error: ?errors.FileContentRequiredException = aws.json.parseJsonObject(errors.FileContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileContentSizeLimitExceededException")) {
        const parsed_error: ?errors.FileContentSizeLimitExceededException = aws.json.parseJsonObject(errors.FileContentSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_content_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileDoesNotExistException")) {
        const parsed_error: ?errors.FileDoesNotExistException = aws.json.parseJsonObject(errors.FileDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileEntryRequiredException")) {
        const parsed_error: ?errors.FileEntryRequiredException = aws.json.parseJsonObject(errors.FileEntryRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_entry_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileModeRequiredException")) {
        const parsed_error: ?errors.FileModeRequiredException = aws.json.parseJsonObject(errors.FileModeRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_mode_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileNameConflictsWithDirectoryNameException")) {
        const parsed_error: ?errors.FileNameConflictsWithDirectoryNameException = aws.json.parseJsonObject(errors.FileNameConflictsWithDirectoryNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_name_conflicts_with_directory_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FilePathConflictsWithSubmodulePathException")) {
        const parsed_error: ?errors.FilePathConflictsWithSubmodulePathException = aws.json.parseJsonObject(errors.FilePathConflictsWithSubmodulePathException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_path_conflicts_with_submodule_path_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileTooLargeException")) {
        const parsed_error: ?errors.FileTooLargeException = aws.json.parseJsonObject(errors.FileTooLargeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_too_large_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FolderContentSizeLimitExceededException")) {
        const parsed_error: ?errors.FolderContentSizeLimitExceededException = aws.json.parseJsonObject(errors.FolderContentSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .folder_content_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FolderDoesNotExistException")) {
        const parsed_error: ?errors.FolderDoesNotExistException = aws.json.parseJsonObject(errors.FolderDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .folder_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatchException")) {
        const parsed_error: ?errors.IdempotencyParameterMismatchException = aws.json.parseJsonObject(errors.IdempotencyParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidActorArnException")) {
        const parsed_error: ?errors.InvalidActorArnException = aws.json.parseJsonObject(errors.InvalidActorArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_actor_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleContentException")) {
        const parsed_error: ?errors.InvalidApprovalRuleContentException = aws.json.parseJsonObject(errors.InvalidApprovalRuleContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_rule_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleNameException")) {
        const parsed_error: ?errors.InvalidApprovalRuleNameException = aws.json.parseJsonObject(errors.InvalidApprovalRuleNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_rule_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateContentException")) {
        const parsed_error: ?errors.InvalidApprovalRuleTemplateContentException = aws.json.parseJsonObject(errors.InvalidApprovalRuleTemplateContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateDescriptionException")) {
        const parsed_error: ?errors.InvalidApprovalRuleTemplateDescriptionException = aws.json.parseJsonObject(errors.InvalidApprovalRuleTemplateDescriptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_description_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateNameException")) {
        const parsed_error: ?errors.InvalidApprovalRuleTemplateNameException = aws.json.parseJsonObject(errors.InvalidApprovalRuleTemplateNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalStateException")) {
        const parsed_error: ?errors.InvalidApprovalStateException = aws.json.parseJsonObject(errors.InvalidApprovalStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_approval_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorArnException")) {
        const parsed_error: ?errors.InvalidAuthorArnException = aws.json.parseJsonObject(errors.InvalidAuthorArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_author_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBlobIdException")) {
        const parsed_error: ?errors.InvalidBlobIdException = aws.json.parseJsonObject(errors.InvalidBlobIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_blob_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidBranchNameException")) {
        const parsed_error: ?errors.InvalidBranchNameException = aws.json.parseJsonObject(errors.InvalidBranchNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_branch_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidClientRequestTokenException")) {
        const parsed_error: ?errors.InvalidClientRequestTokenException = aws.json.parseJsonObject(errors.InvalidClientRequestTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_client_request_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommentIdException")) {
        const parsed_error: ?errors.InvalidCommentIdException = aws.json.parseJsonObject(errors.InvalidCommentIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_comment_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommitException")) {
        const parsed_error: ?errors.InvalidCommitException = aws.json.parseJsonObject(errors.InvalidCommitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_commit_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCommitIdException")) {
        const parsed_error: ?errors.InvalidCommitIdException = aws.json.parseJsonObject(errors.InvalidCommitIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_commit_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictDetailLevelException")) {
        const parsed_error: ?errors.InvalidConflictDetailLevelException = aws.json.parseJsonObject(errors.InvalidConflictDetailLevelException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_conflict_detail_level_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictResolutionException")) {
        const parsed_error: ?errors.InvalidConflictResolutionException = aws.json.parseJsonObject(errors.InvalidConflictResolutionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_conflict_resolution_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictResolutionStrategyException")) {
        const parsed_error: ?errors.InvalidConflictResolutionStrategyException = aws.json.parseJsonObject(errors.InvalidConflictResolutionStrategyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_conflict_resolution_strategy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidContinuationTokenException")) {
        const parsed_error: ?errors.InvalidContinuationTokenException = aws.json.parseJsonObject(errors.InvalidContinuationTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_continuation_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionParameterException")) {
        const parsed_error: ?errors.InvalidDeletionParameterException = aws.json.parseJsonObject(errors.InvalidDeletionParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_deletion_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDescriptionException")) {
        const parsed_error: ?errors.InvalidDescriptionException = aws.json.parseJsonObject(errors.InvalidDescriptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_description_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDestinationCommitSpecifierException")) {
        const parsed_error: ?errors.InvalidDestinationCommitSpecifierException = aws.json.parseJsonObject(errors.InvalidDestinationCommitSpecifierException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_destination_commit_specifier_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEmailException")) {
        const parsed_error: ?errors.InvalidEmailException = aws.json.parseJsonObject(errors.InvalidEmailException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_email_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFileLocationException")) {
        const parsed_error: ?errors.InvalidFileLocationException = aws.json.parseJsonObject(errors.InvalidFileLocationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_file_location_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFileModeException")) {
        const parsed_error: ?errors.InvalidFileModeException = aws.json.parseJsonObject(errors.InvalidFileModeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_file_mode_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilePositionException")) {
        const parsed_error: ?errors.InvalidFilePositionException = aws.json.parseJsonObject(errors.InvalidFilePositionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_file_position_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxConflictFilesException")) {
        const parsed_error: ?errors.InvalidMaxConflictFilesException = aws.json.parseJsonObject(errors.InvalidMaxConflictFilesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_max_conflict_files_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxMergeHunksException")) {
        const parsed_error: ?errors.InvalidMaxMergeHunksException = aws.json.parseJsonObject(errors.InvalidMaxMergeHunksException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_max_merge_hunks_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        const parsed_error: ?errors.InvalidMaxResultsException = aws.json.parseJsonObject(errors.InvalidMaxResultsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMergeOptionException")) {
        const parsed_error: ?errors.InvalidMergeOptionException = aws.json.parseJsonObject(errors.InvalidMergeOptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_merge_option_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOrderException")) {
        const parsed_error: ?errors.InvalidOrderException = aws.json.parseJsonObject(errors.InvalidOrderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_order_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidOverrideStatusException")) {
        const parsed_error: ?errors.InvalidOverrideStatusException = aws.json.parseJsonObject(errors.InvalidOverrideStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_override_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParentCommitIdException")) {
        const parsed_error: ?errors.InvalidParentCommitIdException = aws.json.parseJsonObject(errors.InvalidParentCommitIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parent_commit_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPathException")) {
        const parsed_error: ?errors.InvalidPathException = aws.json.parseJsonObject(errors.InvalidPathException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_path_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestEventTypeException")) {
        const parsed_error: ?errors.InvalidPullRequestEventTypeException = aws.json.parseJsonObject(errors.InvalidPullRequestEventTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pull_request_event_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestIdException")) {
        const parsed_error: ?errors.InvalidPullRequestIdException = aws.json.parseJsonObject(errors.InvalidPullRequestIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pull_request_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestStatusException")) {
        const parsed_error: ?errors.InvalidPullRequestStatusException = aws.json.parseJsonObject(errors.InvalidPullRequestStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pull_request_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestStatusUpdateException")) {
        const parsed_error: ?errors.InvalidPullRequestStatusUpdateException = aws.json.parseJsonObject(errors.InvalidPullRequestStatusUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pull_request_status_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidReactionUserArnException")) {
        const parsed_error: ?errors.InvalidReactionUserArnException = aws.json.parseJsonObject(errors.InvalidReactionUserArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_reaction_user_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidReactionValueException")) {
        const parsed_error: ?errors.InvalidReactionValueException = aws.json.parseJsonObject(errors.InvalidReactionValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_reaction_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidReferenceNameException")) {
        const parsed_error: ?errors.InvalidReferenceNameException = aws.json.parseJsonObject(errors.InvalidReferenceNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_reference_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRelativeFileVersionEnumException")) {
        const parsed_error: ?errors.InvalidRelativeFileVersionEnumException = aws.json.parseJsonObject(errors.InvalidRelativeFileVersionEnumException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_relative_file_version_enum_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidReplacementContentException")) {
        const parsed_error: ?errors.InvalidReplacementContentException = aws.json.parseJsonObject(errors.InvalidReplacementContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_replacement_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidReplacementTypeException")) {
        const parsed_error: ?errors.InvalidReplacementTypeException = aws.json.parseJsonObject(errors.InvalidReplacementTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_replacement_type_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryDescriptionException")) {
        const parsed_error: ?errors.InvalidRepositoryDescriptionException = aws.json.parseJsonObject(errors.InvalidRepositoryDescriptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_description_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryNameException")) {
        const parsed_error: ?errors.InvalidRepositoryNameException = aws.json.parseJsonObject(errors.InvalidRepositoryNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerBranchNameException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerBranchNameException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerBranchNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_branch_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerCustomDataException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerCustomDataException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerCustomDataException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_custom_data_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerDestinationArnException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerDestinationArnException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerDestinationArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_destination_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerEventsException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerEventsException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerEventsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_events_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerNameException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerNameException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerRegionException")) {
        const parsed_error: ?errors.InvalidRepositoryTriggerRegionException = aws.json.parseJsonObject(errors.InvalidRepositoryTriggerRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceArnException")) {
        const parsed_error: ?errors.InvalidResourceArnException = aws.json.parseJsonObject(errors.InvalidResourceArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRevisionIdException")) {
        const parsed_error: ?errors.InvalidRevisionIdException = aws.json.parseJsonObject(errors.InvalidRevisionIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_revision_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRuleContentSha256Exception")) {
        const parsed_error: ?errors.InvalidRuleContentSha256Exception = aws.json.parseJsonObject(errors.InvalidRuleContentSha256Exception, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_rule_content_sha_256_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSortByException")) {
        const parsed_error: ?errors.InvalidSortByException = aws.json.parseJsonObject(errors.InvalidSortByException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sort_by_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceCommitSpecifierException")) {
        const parsed_error: ?errors.InvalidSourceCommitSpecifierException = aws.json.parseJsonObject(errors.InvalidSourceCommitSpecifierException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_source_commit_specifier_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSystemTagUsageException")) {
        const parsed_error: ?errors.InvalidSystemTagUsageException = aws.json.parseJsonObject(errors.InvalidSystemTagUsageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_system_tag_usage_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagKeysListException")) {
        const parsed_error: ?errors.InvalidTagKeysListException = aws.json.parseJsonObject(errors.InvalidTagKeysListException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_keys_list_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagsMapException")) {
        const parsed_error: ?errors.InvalidTagsMapException = aws.json.parseJsonObject(errors.InvalidTagsMapException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tags_map_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetBranchException")) {
        const parsed_error: ?errors.InvalidTargetBranchException = aws.json.parseJsonObject(errors.InvalidTargetBranchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_branch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        const parsed_error: ?errors.InvalidTargetException = aws.json.parseJsonObject(errors.InvalidTargetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_target_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetsException")) {
        const parsed_error: ?errors.InvalidTargetsException = aws.json.parseJsonObject(errors.InvalidTargetsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_targets_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTitleException")) {
        const parsed_error: ?errors.InvalidTitleException = aws.json.parseJsonObject(errors.InvalidTitleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_title_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ManualMergeRequiredException")) {
        const parsed_error: ?errors.ManualMergeRequiredException = aws.json.parseJsonObject(errors.ManualMergeRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .manual_merge_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumBranchesExceededException")) {
        const parsed_error: ?errors.MaximumBranchesExceededException = aws.json.parseJsonObject(errors.MaximumBranchesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_branches_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumConflictResolutionEntriesExceededException")) {
        const parsed_error: ?errors.MaximumConflictResolutionEntriesExceededException = aws.json.parseJsonObject(errors.MaximumConflictResolutionEntriesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_conflict_resolution_entries_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumFileContentToLoadExceededException")) {
        const parsed_error: ?errors.MaximumFileContentToLoadExceededException = aws.json.parseJsonObject(errors.MaximumFileContentToLoadExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_file_content_to_load_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumFileEntriesExceededException")) {
        const parsed_error: ?errors.MaximumFileEntriesExceededException = aws.json.parseJsonObject(errors.MaximumFileEntriesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_file_entries_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumItemsToCompareExceededException")) {
        const parsed_error: ?errors.MaximumItemsToCompareExceededException = aws.json.parseJsonObject(errors.MaximumItemsToCompareExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_items_to_compare_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumNumberOfApprovalsExceededException")) {
        const parsed_error: ?errors.MaximumNumberOfApprovalsExceededException = aws.json.parseJsonObject(errors.MaximumNumberOfApprovalsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_number_of_approvals_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumOpenPullRequestsExceededException")) {
        const parsed_error: ?errors.MaximumOpenPullRequestsExceededException = aws.json.parseJsonObject(errors.MaximumOpenPullRequestsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_open_pull_requests_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumRepositoryNamesExceededException")) {
        const parsed_error: ?errors.MaximumRepositoryNamesExceededException = aws.json.parseJsonObject(errors.MaximumRepositoryNamesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_repository_names_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumRepositoryTriggersExceededException")) {
        const parsed_error: ?errors.MaximumRepositoryTriggersExceededException = aws.json.parseJsonObject(errors.MaximumRepositoryTriggersExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_repository_triggers_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumRuleTemplatesAssociatedWithRepositoryException")) {
        const parsed_error: ?errors.MaximumRuleTemplatesAssociatedWithRepositoryException = aws.json.parseJsonObject(errors.MaximumRuleTemplatesAssociatedWithRepositoryException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_rule_templates_associated_with_repository_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MergeOptionRequiredException")) {
        const parsed_error: ?errors.MergeOptionRequiredException = aws.json.parseJsonObject(errors.MergeOptionRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .merge_option_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultipleConflictResolutionEntriesException")) {
        const parsed_error: ?errors.MultipleConflictResolutionEntriesException = aws.json.parseJsonObject(errors.MultipleConflictResolutionEntriesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multiple_conflict_resolution_entries_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultipleRepositoriesInPullRequestException")) {
        const parsed_error: ?errors.MultipleRepositoriesInPullRequestException = aws.json.parseJsonObject(errors.MultipleRepositoriesInPullRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multiple_repositories_in_pull_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NameLengthExceededException")) {
        const parsed_error: ?errors.NameLengthExceededException = aws.json.parseJsonObject(errors.NameLengthExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .name_length_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoChangeException")) {
        const parsed_error: ?errors.NoChangeException = aws.json.parseJsonObject(errors.NoChangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_change_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NumberOfRuleTemplatesExceededException")) {
        const parsed_error: ?errors.NumberOfRuleTemplatesExceededException = aws.json.parseJsonObject(errors.NumberOfRuleTemplatesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .number_of_rule_templates_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NumberOfRulesExceededException")) {
        const parsed_error: ?errors.NumberOfRulesExceededException = aws.json.parseJsonObject(errors.NumberOfRulesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .number_of_rules_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotAllowedException")) {
        const parsed_error: ?errors.OperationNotAllowedException = aws.json.parseJsonObject(errors.OperationNotAllowedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_allowed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OverrideAlreadySetException")) {
        const parsed_error: ?errors.OverrideAlreadySetException = aws.json.parseJsonObject(errors.OverrideAlreadySetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .override_already_set_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OverrideStatusRequiredException")) {
        const parsed_error: ?errors.OverrideStatusRequiredException = aws.json.parseJsonObject(errors.OverrideStatusRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .override_status_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParentCommitDoesNotExistException")) {
        const parsed_error: ?errors.ParentCommitDoesNotExistException = aws.json.parseJsonObject(errors.ParentCommitDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parent_commit_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParentCommitIdOutdatedException")) {
        const parsed_error: ?errors.ParentCommitIdOutdatedException = aws.json.parseJsonObject(errors.ParentCommitIdOutdatedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parent_commit_id_outdated_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParentCommitIdRequiredException")) {
        const parsed_error: ?errors.ParentCommitIdRequiredException = aws.json.parseJsonObject(errors.ParentCommitIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parent_commit_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PathDoesNotExistException")) {
        const parsed_error: ?errors.PathDoesNotExistException = aws.json.parseJsonObject(errors.PathDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .path_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PathRequiredException")) {
        const parsed_error: ?errors.PathRequiredException = aws.json.parseJsonObject(errors.PathRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .path_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestAlreadyClosedException")) {
        const parsed_error: ?errors.PullRequestAlreadyClosedException = aws.json.parseJsonObject(errors.PullRequestAlreadyClosedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_already_closed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestApprovalRulesNotSatisfiedException")) {
        const parsed_error: ?errors.PullRequestApprovalRulesNotSatisfiedException = aws.json.parseJsonObject(errors.PullRequestApprovalRulesNotSatisfiedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_approval_rules_not_satisfied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestCannotBeApprovedByAuthorException")) {
        const parsed_error: ?errors.PullRequestCannotBeApprovedByAuthorException = aws.json.parseJsonObject(errors.PullRequestCannotBeApprovedByAuthorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_cannot_be_approved_by_author_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestDoesNotExistException")) {
        const parsed_error: ?errors.PullRequestDoesNotExistException = aws.json.parseJsonObject(errors.PullRequestDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestIdRequiredException")) {
        const parsed_error: ?errors.PullRequestIdRequiredException = aws.json.parseJsonObject(errors.PullRequestIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PullRequestStatusRequiredException")) {
        const parsed_error: ?errors.PullRequestStatusRequiredException = aws.json.parseJsonObject(errors.PullRequestStatusRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .pull_request_status_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PutFileEntryConflictException")) {
        const parsed_error: ?errors.PutFileEntryConflictException = aws.json.parseJsonObject(errors.PutFileEntryConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .put_file_entry_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReactionLimitExceededException")) {
        const parsed_error: ?errors.ReactionLimitExceededException = aws.json.parseJsonObject(errors.ReactionLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reaction_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReactionValueRequiredException")) {
        const parsed_error: ?errors.ReactionValueRequiredException = aws.json.parseJsonObject(errors.ReactionValueRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reaction_value_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReferenceDoesNotExistException")) {
        const parsed_error: ?errors.ReferenceDoesNotExistException = aws.json.parseJsonObject(errors.ReferenceDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reference_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReferenceNameRequiredException")) {
        const parsed_error: ?errors.ReferenceNameRequiredException = aws.json.parseJsonObject(errors.ReferenceNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reference_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReferenceTypeNotSupportedException")) {
        const parsed_error: ?errors.ReferenceTypeNotSupportedException = aws.json.parseJsonObject(errors.ReferenceTypeNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reference_type_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplacementContentRequiredException")) {
        const parsed_error: ?errors.ReplacementContentRequiredException = aws.json.parseJsonObject(errors.ReplacementContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replacement_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReplacementTypeRequiredException")) {
        const parsed_error: ?errors.ReplacementTypeRequiredException = aws.json.parseJsonObject(errors.ReplacementTypeRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .replacement_type_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryDoesNotExistException")) {
        const parsed_error: ?errors.RepositoryDoesNotExistException = aws.json.parseJsonObject(errors.RepositoryDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryLimitExceededException")) {
        const parsed_error: ?errors.RepositoryLimitExceededException = aws.json.parseJsonObject(errors.RepositoryLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNameExistsException")) {
        const parsed_error: ?errors.RepositoryNameExistsException = aws.json.parseJsonObject(errors.RepositoryNameExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_name_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNameRequiredException")) {
        const parsed_error: ?errors.RepositoryNameRequiredException = aws.json.parseJsonObject(errors.RepositoryNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNamesRequiredException")) {
        const parsed_error: ?errors.RepositoryNamesRequiredException = aws.json.parseJsonObject(errors.RepositoryNamesRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_names_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotAssociatedWithPullRequestException")) {
        const parsed_error: ?errors.RepositoryNotAssociatedWithPullRequestException = aws.json.parseJsonObject(errors.RepositoryNotAssociatedWithPullRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_not_associated_with_pull_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerBranchNameListRequiredException")) {
        const parsed_error: ?errors.RepositoryTriggerBranchNameListRequiredException = aws.json.parseJsonObject(errors.RepositoryTriggerBranchNameListRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_trigger_branch_name_list_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerDestinationArnRequiredException")) {
        const parsed_error: ?errors.RepositoryTriggerDestinationArnRequiredException = aws.json.parseJsonObject(errors.RepositoryTriggerDestinationArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_trigger_destination_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerEventsListRequiredException")) {
        const parsed_error: ?errors.RepositoryTriggerEventsListRequiredException = aws.json.parseJsonObject(errors.RepositoryTriggerEventsListRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_trigger_events_list_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerNameRequiredException")) {
        const parsed_error: ?errors.RepositoryTriggerNameRequiredException = aws.json.parseJsonObject(errors.RepositoryTriggerNameRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_trigger_name_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggersListRequiredException")) {
        const parsed_error: ?errors.RepositoryTriggersListRequiredException = aws.json.parseJsonObject(errors.RepositoryTriggersListRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .repository_triggers_list_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceArnRequiredException")) {
        const parsed_error: ?errors.ResourceArnRequiredException = aws.json.parseJsonObject(errors.ResourceArnRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_arn_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RestrictedSourceFileException")) {
        const parsed_error: ?errors.RestrictedSourceFileException = aws.json.parseJsonObject(errors.RestrictedSourceFileException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .restricted_source_file_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionIdRequiredException")) {
        const parsed_error: ?errors.RevisionIdRequiredException = aws.json.parseJsonObject(errors.RevisionIdRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_id_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RevisionNotCurrentException")) {
        const parsed_error: ?errors.RevisionNotCurrentException = aws.json.parseJsonObject(errors.RevisionNotCurrentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .revision_not_current_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SameFileContentException")) {
        const parsed_error: ?errors.SameFileContentException = aws.json.parseJsonObject(errors.SameFileContentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .same_file_content_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SamePathRequestException")) {
        const parsed_error: ?errors.SamePathRequestException = aws.json.parseJsonObject(errors.SamePathRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .same_path_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SourceAndDestinationAreSameException")) {
        const parsed_error: ?errors.SourceAndDestinationAreSameException = aws.json.parseJsonObject(errors.SourceAndDestinationAreSameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .source_and_destination_are_same_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SourceFileOrContentRequiredException")) {
        const parsed_error: ?errors.SourceFileOrContentRequiredException = aws.json.parseJsonObject(errors.SourceFileOrContentRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .source_file_or_content_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagKeysListRequiredException")) {
        const parsed_error: ?errors.TagKeysListRequiredException = aws.json.parseJsonObject(errors.TagKeysListRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_keys_list_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        const parsed_error: ?errors.TagPolicyException = aws.json.parseJsonObject(errors.TagPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagsMapRequiredException")) {
        const parsed_error: ?errors.TagsMapRequiredException = aws.json.parseJsonObject(errors.TagsMapRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tags_map_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetRequiredException")) {
        const parsed_error: ?errors.TargetRequiredException = aws.json.parseJsonObject(errors.TargetRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetsRequiredException")) {
        const parsed_error: ?errors.TargetsRequiredException = aws.json.parseJsonObject(errors.TargetsRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .targets_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TipOfSourceReferenceIsDifferentException")) {
        const parsed_error: ?errors.TipOfSourceReferenceIsDifferentException = aws.json.parseJsonObject(errors.TipOfSourceReferenceIsDifferentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tip_of_source_reference_is_different_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TipsDivergenceExceededException")) {
        const parsed_error: ?errors.TipsDivergenceExceededException = aws.json.parseJsonObject(errors.TipsDivergenceExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tips_divergence_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TitleRequiredException")) {
        const parsed_error: ?errors.TitleRequiredException = aws.json.parseJsonObject(errors.TitleRequiredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .title_required_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
