const std = @import("std");

pub const AgreementStatus = enum {
    active,
    archived,
    cancelled,
    expired,
    renewed,
    replaced,
    rolled_back,
    superseded,
    terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .cancelled = "CANCELLED",
        .expired = "EXPIRED",
        .renewed = "RENEWED",
        .replaced = "REPLACED",
        .rolled_back = "ROLLED_BACK",
        .superseded = "SUPERSEDED",
        .terminated = "TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .archived => "ARCHIVED",
            .cancelled => "CANCELLED",
            .expired => "EXPIRED",
            .renewed => "RENEWED",
            .replaced => "REPLACED",
            .rolled_back => "ROLLED_BACK",
            .superseded => "SUPERSEDED",
            .terminated => "TERMINATED",
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
