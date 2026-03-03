const std = @import("std");

/// Specifies why occurrences of sensitive data can't be retrieved for a
/// finding. Possible values are:
pub const UnavailabilityReasonCode = enum {
    object_exceeds_size_quota,
    unsupported_object_type,
    unsupported_finding_type,
    invalid_classification_result,
    object_unavailable,
    account_not_in_organization,
    missing_get_member_permission,
    role_too_permissive,
    member_role_too_permissive,
    invalid_result_signature,
    result_not_signed,

    pub const json_field_names = .{
        .object_exceeds_size_quota = "OBJECT_EXCEEDS_SIZE_QUOTA",
        .unsupported_object_type = "UNSUPPORTED_OBJECT_TYPE",
        .unsupported_finding_type = "UNSUPPORTED_FINDING_TYPE",
        .invalid_classification_result = "INVALID_CLASSIFICATION_RESULT",
        .object_unavailable = "OBJECT_UNAVAILABLE",
        .account_not_in_organization = "ACCOUNT_NOT_IN_ORGANIZATION",
        .missing_get_member_permission = "MISSING_GET_MEMBER_PERMISSION",
        .role_too_permissive = "ROLE_TOO_PERMISSIVE",
        .member_role_too_permissive = "MEMBER_ROLE_TOO_PERMISSIVE",
        .invalid_result_signature = "INVALID_RESULT_SIGNATURE",
        .result_not_signed = "RESULT_NOT_SIGNED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .object_exceeds_size_quota => "OBJECT_EXCEEDS_SIZE_QUOTA",
            .unsupported_object_type => "UNSUPPORTED_OBJECT_TYPE",
            .unsupported_finding_type => "UNSUPPORTED_FINDING_TYPE",
            .invalid_classification_result => "INVALID_CLASSIFICATION_RESULT",
            .object_unavailable => "OBJECT_UNAVAILABLE",
            .account_not_in_organization => "ACCOUNT_NOT_IN_ORGANIZATION",
            .missing_get_member_permission => "MISSING_GET_MEMBER_PERMISSION",
            .role_too_permissive => "ROLE_TOO_PERMISSIVE",
            .member_role_too_permissive => "MEMBER_ROLE_TOO_PERMISSIVE",
            .invalid_result_signature => "INVALID_RESULT_SIGNATURE",
            .result_not_signed => "RESULT_NOT_SIGNED",
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
