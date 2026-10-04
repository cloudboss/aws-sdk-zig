const std = @import("std");

/// The filter key to use when listing email identities. This can be one of the
/// following:
///
/// * `IDENTITY_NAME_CONTAINS` – Filter by a substring of the identity name.
///
/// * `IDENTITY_TYPE` – Filter by identity type.
///
/// * `VERIFICATION_STATUS` – Filter by verification status.
pub const IdentityFilterKey = enum {
    identity_name_contains,
    identity_type,
    verification_status,

    pub const json_field_names = .{
        .identity_name_contains = "IDENTITY_NAME_CONTAINS",
        .identity_type = "IDENTITY_TYPE",
        .verification_status = "VERIFICATION_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity_name_contains => "IDENTITY_NAME_CONTAINS",
            .identity_type => "IDENTITY_TYPE",
            .verification_status => "VERIFICATION_STATUS",
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
