const std = @import("std");

pub const ReferrerPolicyList = enum {
    no_referrer,
    no_referrer_when_downgrade,
    origin,
    origin_when_cross_origin,
    same_origin,
    strict_origin,
    strict_origin_when_cross_origin,
    unsafe_url,

    pub const json_field_names = .{
        .no_referrer = "no-referrer",
        .no_referrer_when_downgrade = "no-referrer-when-downgrade",
        .origin = "origin",
        .origin_when_cross_origin = "origin-when-cross-origin",
        .same_origin = "same-origin",
        .strict_origin = "strict-origin",
        .strict_origin_when_cross_origin = "strict-origin-when-cross-origin",
        .unsafe_url = "unsafe-url",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_referrer => "no-referrer",
            .no_referrer_when_downgrade => "no-referrer-when-downgrade",
            .origin => "origin",
            .origin_when_cross_origin => "origin-when-cross-origin",
            .same_origin => "same-origin",
            .strict_origin => "strict-origin",
            .strict_origin_when_cross_origin => "strict-origin-when-cross-origin",
            .unsafe_url => "unsafe-url",
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
