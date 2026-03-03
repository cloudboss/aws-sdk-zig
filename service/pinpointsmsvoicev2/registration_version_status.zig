const std = @import("std");

pub const RegistrationVersionStatus = enum {
    draft,
    submitted,
    aws_reviewing,
    reviewing,
    requires_authentication,
    approved,
    discarded,
    denied,
    revoked,
    archived,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .submitted = "SUBMITTED",
        .aws_reviewing = "AWS_REVIEWING",
        .reviewing = "REVIEWING",
        .requires_authentication = "REQUIRES_AUTHENTICATION",
        .approved = "APPROVED",
        .discarded = "DISCARDED",
        .denied = "DENIED",
        .revoked = "REVOKED",
        .archived = "ARCHIVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .draft => "DRAFT",
            .submitted => "SUBMITTED",
            .aws_reviewing => "AWS_REVIEWING",
            .reviewing => "REVIEWING",
            .requires_authentication => "REQUIRES_AUTHENTICATION",
            .approved => "APPROVED",
            .discarded => "DISCARDED",
            .denied => "DENIED",
            .revoked => "REVOKED",
            .archived => "ARCHIVED",
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
