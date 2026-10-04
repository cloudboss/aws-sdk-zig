const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        batch_write_exception: BatchWriteException,
        cannot_list_parent_of_root_exception: CannotListParentOfRootException,
        directory_already_exists_exception: DirectoryAlreadyExistsException,
        directory_deleted_exception: DirectoryDeletedException,
        directory_not_disabled_exception: DirectoryNotDisabledException,
        directory_not_enabled_exception: DirectoryNotEnabledException,
        facet_already_exists_exception: FacetAlreadyExistsException,
        facet_in_use_exception: FacetInUseException,
        facet_not_found_exception: FacetNotFoundException,
        facet_validation_exception: FacetValidationException,
        incompatible_schema_exception: IncompatibleSchemaException,
        indexed_attribute_missing_exception: IndexedAttributeMissingException,
        internal_service_exception: InternalServiceException,
        invalid_arn_exception: InvalidArnException,
        invalid_attachment_exception: InvalidAttachmentException,
        invalid_facet_update_exception: InvalidFacetUpdateException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_rule_exception: InvalidRuleException,
        invalid_schema_doc_exception: InvalidSchemaDocException,
        invalid_tagging_request_exception: InvalidTaggingRequestException,
        limit_exceeded_exception: LimitExceededException,
        link_name_already_in_use_exception: LinkNameAlreadyInUseException,
        not_index_exception: NotIndexException,
        not_node_exception: NotNodeException,
        not_policy_exception: NotPolicyException,
        object_already_detached_exception: ObjectAlreadyDetachedException,
        object_not_detached_exception: ObjectNotDetachedException,
        resource_not_found_exception: ResourceNotFoundException,
        retryable_conflict_exception: RetryableConflictException,
        schema_already_exists_exception: SchemaAlreadyExistsException,
        schema_already_published_exception: SchemaAlreadyPublishedException,
        still_contains_links_exception: StillContainsLinksException,
        unsupported_index_type_exception: UnsupportedIndexTypeException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .batch_write_exception => "BatchWriteException",
                .cannot_list_parent_of_root_exception => "CannotListParentOfRootException",
                .directory_already_exists_exception => "DirectoryAlreadyExistsException",
                .directory_deleted_exception => "DirectoryDeletedException",
                .directory_not_disabled_exception => "DirectoryNotDisabledException",
                .directory_not_enabled_exception => "DirectoryNotEnabledException",
                .facet_already_exists_exception => "FacetAlreadyExistsException",
                .facet_in_use_exception => "FacetInUseException",
                .facet_not_found_exception => "FacetNotFoundException",
                .facet_validation_exception => "FacetValidationException",
                .incompatible_schema_exception => "IncompatibleSchemaException",
                .indexed_attribute_missing_exception => "IndexedAttributeMissingException",
                .internal_service_exception => "InternalServiceException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_attachment_exception => "InvalidAttachmentException",
                .invalid_facet_update_exception => "InvalidFacetUpdateException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_rule_exception => "InvalidRuleException",
                .invalid_schema_doc_exception => "InvalidSchemaDocException",
                .invalid_tagging_request_exception => "InvalidTaggingRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .link_name_already_in_use_exception => "LinkNameAlreadyInUseException",
                .not_index_exception => "NotIndexException",
                .not_node_exception => "NotNodeException",
                .not_policy_exception => "NotPolicyException",
                .object_already_detached_exception => "ObjectAlreadyDetachedException",
                .object_not_detached_exception => "ObjectNotDetachedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .retryable_conflict_exception => "RetryableConflictException",
                .schema_already_exists_exception => "SchemaAlreadyExistsException",
                .schema_already_published_exception => "SchemaAlreadyPublishedException",
                .still_contains_links_exception => "StillContainsLinksException",
                .unsupported_index_type_exception => "UnsupportedIndexTypeException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .batch_write_exception => |e| e.message,
                .cannot_list_parent_of_root_exception => |e| e.message,
                .directory_already_exists_exception => |e| e.message,
                .directory_deleted_exception => |e| e.message,
                .directory_not_disabled_exception => |e| e.message,
                .directory_not_enabled_exception => |e| e.message,
                .facet_already_exists_exception => |e| e.message,
                .facet_in_use_exception => |e| e.message,
                .facet_not_found_exception => |e| e.message,
                .facet_validation_exception => |e| e.message,
                .incompatible_schema_exception => |e| e.message,
                .indexed_attribute_missing_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_attachment_exception => |e| e.message,
                .invalid_facet_update_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_rule_exception => |e| e.message,
                .invalid_schema_doc_exception => |e| e.message,
                .invalid_tagging_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .link_name_already_in_use_exception => |e| e.message,
                .not_index_exception => |e| e.message,
                .not_node_exception => |e| e.message,
                .not_policy_exception => |e| e.message,
                .object_already_detached_exception => |e| e.message,
                .object_not_detached_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .retryable_conflict_exception => |e| e.message,
                .schema_already_exists_exception => |e| e.message,
                .schema_already_published_exception => |e| e.message,
                .still_contains_links_exception => |e| e.message,
                .unsupported_index_type_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .batch_write_exception => 400,
                .cannot_list_parent_of_root_exception => 400,
                .directory_already_exists_exception => 400,
                .directory_deleted_exception => 400,
                .directory_not_disabled_exception => 400,
                .directory_not_enabled_exception => 400,
                .facet_already_exists_exception => 400,
                .facet_in_use_exception => 400,
                .facet_not_found_exception => 400,
                .facet_validation_exception => 400,
                .incompatible_schema_exception => 400,
                .indexed_attribute_missing_exception => 400,
                .internal_service_exception => 500,
                .invalid_arn_exception => 400,
                .invalid_attachment_exception => 400,
                .invalid_facet_update_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_rule_exception => 400,
                .invalid_schema_doc_exception => 400,
                .invalid_tagging_request_exception => 400,
                .limit_exceeded_exception => 400,
                .link_name_already_in_use_exception => 400,
                .not_index_exception => 400,
                .not_node_exception => 400,
                .not_policy_exception => 400,
                .object_already_detached_exception => 400,
                .object_not_detached_exception => 400,
                .resource_not_found_exception => 404,
                .retryable_conflict_exception => 409,
                .schema_already_exists_exception => 400,
                .schema_already_published_exception => 400,
                .still_contains_links_exception => 400,
                .unsupported_index_type_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .batch_write_exception => |e| e.request_id,
                .cannot_list_parent_of_root_exception => |e| e.request_id,
                .directory_already_exists_exception => |e| e.request_id,
                .directory_deleted_exception => |e| e.request_id,
                .directory_not_disabled_exception => |e| e.request_id,
                .directory_not_enabled_exception => |e| e.request_id,
                .facet_already_exists_exception => |e| e.request_id,
                .facet_in_use_exception => |e| e.request_id,
                .facet_not_found_exception => |e| e.request_id,
                .facet_validation_exception => |e| e.request_id,
                .incompatible_schema_exception => |e| e.request_id,
                .indexed_attribute_missing_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_attachment_exception => |e| e.request_id,
                .invalid_facet_update_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_rule_exception => |e| e.request_id,
                .invalid_schema_doc_exception => |e| e.request_id,
                .invalid_tagging_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .link_name_already_in_use_exception => |e| e.request_id,
                .not_index_exception => |e| e.request_id,
                .not_node_exception => |e| e.request_id,
                .not_policy_exception => |e| e.request_id,
                .object_already_detached_exception => |e| e.request_id,
                .object_not_detached_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .retryable_conflict_exception => |e| e.request_id,
                .schema_already_exists_exception => |e| e.request_id,
                .schema_already_published_exception => |e| e.request_id,
                .still_contains_links_exception => |e| e.request_id,
                .unsupported_index_type_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchWriteException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CannotListParentOfRootException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryDeletedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryNotDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectoryNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FacetAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FacetInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FacetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FacetValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleSchemaException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IndexedAttributeMissingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAttachmentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFacetUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSchemaDocException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTaggingRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LinkNameAlreadyInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotIndexException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotNodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectAlreadyDetachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectNotDetachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RetryableConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SchemaAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SchemaAlreadyPublishedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StillContainsLinksException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedIndexTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchWriteException")) {
        return .{ .arena = arena, .kind = .{ .batch_write_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotListParentOfRootException")) {
        return .{ .arena = arena, .kind = .{ .cannot_list_parent_of_root_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .directory_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryDeletedException")) {
        return .{ .arena = arena, .kind = .{ .directory_deleted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryNotDisabledException")) {
        return .{ .arena = arena, .kind = .{ .directory_not_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .directory_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FacetAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .facet_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FacetInUseException")) {
        return .{ .arena = arena, .kind = .{ .facet_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FacetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .facet_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FacetValidationException")) {
        return .{ .arena = arena, .kind = .{ .facet_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleSchemaException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_schema_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IndexedAttributeMissingException")) {
        return .{ .arena = arena, .kind = .{ .indexed_attribute_missing_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAttachmentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_attachment_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFacetUpdateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_facet_update_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRuleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchemaDocException")) {
        return .{ .arena = arena, .kind = .{ .invalid_schema_doc_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTaggingRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tagging_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LinkNameAlreadyInUseException")) {
        return .{ .arena = arena, .kind = .{ .link_name_already_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotIndexException")) {
        return .{ .arena = arena, .kind = .{ .not_index_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotNodeException")) {
        return .{ .arena = arena, .kind = .{ .not_node_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotPolicyException")) {
        return .{ .arena = arena, .kind = .{ .not_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyDetachedException")) {
        return .{ .arena = arena, .kind = .{ .object_already_detached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotDetachedException")) {
        return .{ .arena = arena, .kind = .{ .object_not_detached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RetryableConflictException")) {
        return .{ .arena = arena, .kind = .{ .retryable_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchemaAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .schema_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchemaAlreadyPublishedException")) {
        return .{ .arena = arena, .kind = .{ .schema_already_published_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StillContainsLinksException")) {
        return .{ .arena = arena, .kind = .{ .still_contains_links_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedIndexTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_index_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
