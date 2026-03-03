const std = @import("std");

pub const DnsNameState = enum {
    pending_verification,
    verified,
    failed,

    pub const json_field_names = .{
        .pending_verification = "pendingVerification",
        .verified = "verified",
        .failed = "failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_verification => "pendingVerification",
            .verified => "verified",
            .failed => "failed",
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
