const std = @import("std");

pub const ShareRequestStatus = enum {
    active,
    replicating,
    shared,
    expiring,
    failed,
    expired,
    declined,
    revoked,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .replicating = "REPLICATING",
        .shared = "SHARED",
        .expiring = "EXPIRING",
        .failed = "FAILED",
        .expired = "EXPIRED",
        .declined = "DECLINED",
        .revoked = "REVOKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .replicating => "REPLICATING",
            .shared => "SHARED",
            .expiring => "EXPIRING",
            .failed => "FAILED",
            .expired => "EXPIRED",
            .declined => "DECLINED",
            .revoked => "REVOKED",
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
