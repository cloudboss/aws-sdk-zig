const std = @import("std");

pub const RevocationReason = enum {
    unspecified,
    key_compromise,
    certificate_authority_compromise,
    affiliation_changed,
    superseded,
    cessation_of_operation,
    privilege_withdrawn,
    a_a_compromise,

    pub const json_field_names = .{
        .unspecified = "UNSPECIFIED",
        .key_compromise = "KEY_COMPROMISE",
        .certificate_authority_compromise = "CERTIFICATE_AUTHORITY_COMPROMISE",
        .affiliation_changed = "AFFILIATION_CHANGED",
        .superseded = "SUPERSEDED",
        .cessation_of_operation = "CESSATION_OF_OPERATION",
        .privilege_withdrawn = "PRIVILEGE_WITHDRAWN",
        .a_a_compromise = "A_A_COMPROMISE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unspecified => "UNSPECIFIED",
            .key_compromise => "KEY_COMPROMISE",
            .certificate_authority_compromise => "CERTIFICATE_AUTHORITY_COMPROMISE",
            .affiliation_changed => "AFFILIATION_CHANGED",
            .superseded => "SUPERSEDED",
            .cessation_of_operation => "CESSATION_OF_OPERATION",
            .privilege_withdrawn => "PRIVILEGE_WITHDRAWN",
            .a_a_compromise => "A_A_COMPROMISE",
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
