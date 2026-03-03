const std = @import("std");

/// The status of the share request.
pub const ShareStatus = enum {
    accepted,
    rejected,
    pending,
    revoked,
    expired,
    associating,
    associated,
    failed,

    pub const json_field_names = .{
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .pending = "PENDING",
        .revoked = "REVOKED",
        .expired = "EXPIRED",
        .associating = "ASSOCIATING",
        .associated = "ASSOCIATED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accepted => "ACCEPTED",
            .rejected => "REJECTED",
            .pending => "PENDING",
            .revoked => "REVOKED",
            .expired => "EXPIRED",
            .associating => "ASSOCIATING",
            .associated => "ASSOCIATED",
            .failed => "FAILED",
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
