const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PullRequest = @import("pull_request.zig").PullRequest;

pub const UpdatePullRequestDescriptionInput = struct {
    /// The updated content of the description for the pull request. This content
    /// replaces the
    /// existing description.
    description: []const u8,

    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .pull_request_id = "pullRequestId",
    };
};

pub const UpdatePullRequestDescriptionOutput = struct {
    /// Information about the updated pull request.
    pull_request: ?PullRequest = null,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePullRequestDescriptionInput, options: Options) !UpdatePullRequestDescriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codecommit");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdatePullRequestDescriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "CodeCommit_20150413.UpdatePullRequestDescription");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdatePullRequestDescriptionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdatePullRequestDescriptionOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ActorDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .actor_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleNameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_template_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_template_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateInUseException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_template_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateNameAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_template_name_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalRuleTemplateNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .approval_rule_template_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApprovalStateRequiredException")) {
        return .{ .arena = arena, .kind = .{ .approval_state_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .author_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BeforeCommitIdAndAfterCommitIdAreSameException")) {
        return .{ .arena = arena, .kind = .{ .before_commit_id_and_after_commit_id_are_same_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlobIdDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .blob_id_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlobIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .blob_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BranchDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .branch_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BranchNameExistsException")) {
        return .{ .arena = arena, .kind = .{ .branch_name_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BranchNameIsTagNameException")) {
        return .{ .arena = arena, .kind = .{ .branch_name_is_tag_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BranchNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .branch_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteApprovalRuleFromTemplateException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_approval_rule_from_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotModifyApprovalRuleFromTemplateException")) {
        return .{ .arena = arena, .kind = .{ .cannot_modify_approval_rule_from_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientRequestTokenRequiredException")) {
        return .{ .arena = arena, .kind = .{ .client_request_token_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .comment_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentContentSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .comment_content_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentDeletedException")) {
        return .{ .arena = arena, .kind = .{ .comment_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .comment_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .comment_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommentNotCreatedByCallerException")) {
        return .{ .arena = arena, .kind = .{ .comment_not_created_by_caller_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .commit_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitIdDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .commit_id_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .commit_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitIdsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .commit_ids_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitIdsListRequiredException")) {
        return .{ .arena = arena, .kind = .{ .commit_ids_list_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitMessageLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .commit_message_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CommitRequiredException")) {
        return .{ .arena = arena, .kind = .{ .commit_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentReferenceUpdateException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_reference_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DefaultBranchCannotBeDeletedException")) {
        return .{ .arena = arena, .kind = .{ .default_branch_cannot_be_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryNameConflictsWithFileNameException")) {
        return .{ .arena = arena, .kind = .{ .directory_name_conflicts_with_file_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionIntegrityChecksFailedException")) {
        return .{ .arena = arena, .kind = .{ .encryption_integrity_checks_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyDisabledException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyInvalidIdException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_invalid_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyInvalidUsageException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_invalid_usage_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyRequiredException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionKeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .encryption_key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileContentAndSourceFileSpecifiedException")) {
        return .{ .arena = arena, .kind = .{ .file_content_and_source_file_specified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .file_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileContentSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .file_content_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .file_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileEntryRequiredException")) {
        return .{ .arena = arena, .kind = .{ .file_entry_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileModeRequiredException")) {
        return .{ .arena = arena, .kind = .{ .file_mode_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileNameConflictsWithDirectoryNameException")) {
        return .{ .arena = arena, .kind = .{ .file_name_conflicts_with_directory_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FilePathConflictsWithSubmodulePathException")) {
        return .{ .arena = arena, .kind = .{ .file_path_conflicts_with_submodule_path_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .file_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FolderContentSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .folder_content_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FolderDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .folder_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidActorArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_actor_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_rule_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_rule_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateDescriptionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_description_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalRuleTemplateNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_rule_template_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidApprovalStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_approval_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_author_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBlobIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_blob_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBranchNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_branch_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientRequestTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_request_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommentIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_comment_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommitException")) {
        return .{ .arena = arena, .kind = .{ .invalid_commit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCommitIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_commit_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictDetailLevelException")) {
        return .{ .arena = arena, .kind = .{ .invalid_conflict_detail_level_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictResolutionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_conflict_resolution_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConflictResolutionStrategyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_conflict_resolution_strategy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidContinuationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_continuation_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDeletionParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_deletion_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDescriptionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_description_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDestinationCommitSpecifierException")) {
        return .{ .arena = arena, .kind = .{ .invalid_destination_commit_specifier_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEmailException")) {
        return .{ .arena = arena, .kind = .{ .invalid_email_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFileLocationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_file_location_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFileModeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_file_mode_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilePositionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_file_position_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxConflictFilesException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_conflict_files_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxMergeHunksException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_merge_hunks_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMergeOptionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_merge_option_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOrderException")) {
        return .{ .arena = arena, .kind = .{ .invalid_order_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOverrideStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_override_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParentCommitIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parent_commit_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPathException")) {
        return .{ .arena = arena, .kind = .{ .invalid_path_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestEventTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pull_request_event_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pull_request_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pull_request_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPullRequestStatusUpdateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pull_request_status_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReactionUserArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_reaction_user_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReactionValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_reaction_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReferenceNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_reference_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRelativeFileVersionEnumException")) {
        return .{ .arena = arena, .kind = .{ .invalid_relative_file_version_enum_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReplacementContentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_replacement_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReplacementTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_replacement_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryDescriptionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_description_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerBranchNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_branch_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerCustomDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_custom_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerDestinationArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_destination_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerEventsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_events_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRepositoryTriggerRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_repository_trigger_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuleContentSha256Exception")) {
        return .{ .arena = arena, .kind = .{ .invalid_rule_content_sha_256_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSortByException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sort_by_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceCommitSpecifierException")) {
        return .{ .arena = arena, .kind = .{ .invalid_source_commit_specifier_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSystemTagUsageException")) {
        return .{ .arena = arena, .kind = .{ .invalid_system_tag_usage_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagKeysListException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_keys_list_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagsMapException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tags_map_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetBranchException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_branch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_targets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTitleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_title_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManualMergeRequiredException")) {
        return .{ .arena = arena, .kind = .{ .manual_merge_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumBranchesExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_branches_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumConflictResolutionEntriesExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_conflict_resolution_entries_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumFileContentToLoadExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_file_content_to_load_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumFileEntriesExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_file_entries_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumItemsToCompareExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_items_to_compare_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumNumberOfApprovalsExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_number_of_approvals_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumOpenPullRequestsExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_open_pull_requests_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumRepositoryNamesExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_repository_names_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumRepositoryTriggersExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_repository_triggers_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumRuleTemplatesAssociatedWithRepositoryException")) {
        return .{ .arena = arena, .kind = .{ .maximum_rule_templates_associated_with_repository_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MergeOptionRequiredException")) {
        return .{ .arena = arena, .kind = .{ .merge_option_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MultipleConflictResolutionEntriesException")) {
        return .{ .arena = arena, .kind = .{ .multiple_conflict_resolution_entries_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MultipleRepositoriesInPullRequestException")) {
        return .{ .arena = arena, .kind = .{ .multiple_repositories_in_pull_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NameLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .name_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoChangeException")) {
        return .{ .arena = arena, .kind = .{ .no_change_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfRuleTemplatesExceededException")) {
        return .{ .arena = arena, .kind = .{ .number_of_rule_templates_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfRulesExceededException")) {
        return .{ .arena = arena, .kind = .{ .number_of_rules_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OverrideAlreadySetException")) {
        return .{ .arena = arena, .kind = .{ .override_already_set_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OverrideStatusRequiredException")) {
        return .{ .arena = arena, .kind = .{ .override_status_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParentCommitDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .parent_commit_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParentCommitIdOutdatedException")) {
        return .{ .arena = arena, .kind = .{ .parent_commit_id_outdated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParentCommitIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .parent_commit_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PathDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .path_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PathRequiredException")) {
        return .{ .arena = arena, .kind = .{ .path_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestAlreadyClosedException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_already_closed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestApprovalRulesNotSatisfiedException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_approval_rules_not_satisfied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestCannotBeApprovedByAuthorException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_cannot_be_approved_by_author_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PullRequestStatusRequiredException")) {
        return .{ .arena = arena, .kind = .{ .pull_request_status_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PutFileEntryConflictException")) {
        return .{ .arena = arena, .kind = .{ .put_file_entry_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReactionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .reaction_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReactionValueRequiredException")) {
        return .{ .arena = arena, .kind = .{ .reaction_value_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReferenceDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .reference_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReferenceNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .reference_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReferenceTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .reference_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplacementContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .replacement_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplacementTypeRequiredException")) {
        return .{ .arena = arena, .kind = .{ .replacement_type_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .repository_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .repository_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNameExistsException")) {
        return .{ .arena = arena, .kind = .{ .repository_name_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNamesRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_names_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryNotAssociatedWithPullRequestException")) {
        return .{ .arena = arena, .kind = .{ .repository_not_associated_with_pull_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerBranchNameListRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_trigger_branch_name_list_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerDestinationArnRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_trigger_destination_arn_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerEventsListRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_trigger_events_list_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggerNameRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_trigger_name_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RepositoryTriggersListRequiredException")) {
        return .{ .arena = arena, .kind = .{ .repository_triggers_list_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceArnRequiredException")) {
        return .{ .arena = arena, .kind = .{ .resource_arn_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RestrictedSourceFileException")) {
        return .{ .arena = arena, .kind = .{ .restricted_source_file_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevisionIdRequiredException")) {
        return .{ .arena = arena, .kind = .{ .revision_id_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RevisionNotCurrentException")) {
        return .{ .arena = arena, .kind = .{ .revision_not_current_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SameFileContentException")) {
        return .{ .arena = arena, .kind = .{ .same_file_content_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SamePathRequestException")) {
        return .{ .arena = arena, .kind = .{ .same_path_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceAndDestinationAreSameException")) {
        return .{ .arena = arena, .kind = .{ .source_and_destination_are_same_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceFileOrContentRequiredException")) {
        return .{ .arena = arena, .kind = .{ .source_file_or_content_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagKeysListRequiredException")) {
        return .{ .arena = arena, .kind = .{ .tag_keys_list_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagsMapRequiredException")) {
        return .{ .arena = arena, .kind = .{ .tags_map_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetRequiredException")) {
        return .{ .arena = arena, .kind = .{ .target_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetsRequiredException")) {
        return .{ .arena = arena, .kind = .{ .targets_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TipOfSourceReferenceIsDifferentException")) {
        return .{ .arena = arena, .kind = .{ .tip_of_source_reference_is_different_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TipsDivergenceExceededException")) {
        return .{ .arena = arena, .kind = .{ .tips_divergence_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TitleRequiredException")) {
        return .{ .arena = arena, .kind = .{ .title_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
