const std = @import("std");

pub const EmotionName = enum {
    happy,
    sad,
    angry,
    confused,
    disgusted,
    surprised,
    calm,
    unknown,
    fear,

    pub const json_field_names = .{
        .happy = "HAPPY",
        .sad = "SAD",
        .angry = "ANGRY",
        .confused = "CONFUSED",
        .disgusted = "DISGUSTED",
        .surprised = "SURPRISED",
        .calm = "CALM",
        .unknown = "UNKNOWN",
        .fear = "FEAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .happy => "HAPPY",
            .sad => "SAD",
            .angry => "ANGRY",
            .confused => "CONFUSED",
            .disgusted => "DISGUSTED",
            .surprised => "SURPRISED",
            .calm => "CALM",
            .unknown => "UNKNOWN",
            .fear => "FEAR",
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
