const std = @import("std");

pub const InternalAccessType = enum {
    intra_account,
    intra_org,

    pub const json_field_names = .{
        .intra_account = "INTRA_ACCOUNT",
        .intra_org = "INTRA_ORG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intra_account => "INTRA_ACCOUNT",
            .intra_org => "INTRA_ORG",
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
