const std = @import("std");

pub const AgreementStatus = enum {
    available,
    pending,
    not_available,
    @"error",

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .not_available = "NOT_AVAILABLE",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .pending => "PENDING",
            .not_available => "NOT_AVAILABLE",
            .@"error" => "ERROR",
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
