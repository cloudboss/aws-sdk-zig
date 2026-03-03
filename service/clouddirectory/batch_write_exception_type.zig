const std = @import("std");

pub const BatchWriteExceptionType = enum {
    internal_service_exception,
    validation_exception,
    invalid_arn_exception,
    link_name_already_in_use_exception,
    still_contains_links_exception,
    facet_validation_exception,
    object_not_detached_exception,
    resource_not_found_exception,
    access_denied_exception,
    invalid_attachment_exception,
    not_index_exception,
    not_node_exception,
    indexed_attribute_missing_exception,
    object_already_detached_exception,
    not_policy_exception,
    directory_not_enabled_exception,
    limit_exceeded_exception,
    unsupported_index_type_exception,

    pub const json_field_names = .{
        .internal_service_exception = "InternalServiceException",
        .validation_exception = "ValidationException",
        .invalid_arn_exception = "InvalidArnException",
        .link_name_already_in_use_exception = "LinkNameAlreadyInUseException",
        .still_contains_links_exception = "StillContainsLinksException",
        .facet_validation_exception = "FacetValidationException",
        .object_not_detached_exception = "ObjectNotDetachedException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .access_denied_exception = "AccessDeniedException",
        .invalid_attachment_exception = "InvalidAttachmentException",
        .not_index_exception = "NotIndexException",
        .not_node_exception = "NotNodeException",
        .indexed_attribute_missing_exception = "IndexedAttributeMissingException",
        .object_already_detached_exception = "ObjectAlreadyDetachedException",
        .not_policy_exception = "NotPolicyException",
        .directory_not_enabled_exception = "DirectoryNotEnabledException",
        .limit_exceeded_exception = "LimitExceededException",
        .unsupported_index_type_exception = "UnsupportedIndexTypeException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_service_exception => "InternalServiceException",
            .validation_exception => "ValidationException",
            .invalid_arn_exception => "InvalidArnException",
            .link_name_already_in_use_exception => "LinkNameAlreadyInUseException",
            .still_contains_links_exception => "StillContainsLinksException",
            .facet_validation_exception => "FacetValidationException",
            .object_not_detached_exception => "ObjectNotDetachedException",
            .resource_not_found_exception => "ResourceNotFoundException",
            .access_denied_exception => "AccessDeniedException",
            .invalid_attachment_exception => "InvalidAttachmentException",
            .not_index_exception => "NotIndexException",
            .not_node_exception => "NotNodeException",
            .indexed_attribute_missing_exception => "IndexedAttributeMissingException",
            .object_already_detached_exception => "ObjectAlreadyDetachedException",
            .not_policy_exception => "NotPolicyException",
            .directory_not_enabled_exception => "DirectoryNotEnabledException",
            .limit_exceeded_exception => "LimitExceededException",
            .unsupported_index_type_exception => "UnsupportedIndexTypeException",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
