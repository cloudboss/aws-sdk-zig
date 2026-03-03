const std = @import("std");

pub const PartnerAppType = enum {
    lakera_guard,
    comet,
    deepchecks_llm_evaluation,
    fiddler,

    pub const json_field_names = .{
        .lakera_guard = "lakera-guard",
        .comet = "comet",
        .deepchecks_llm_evaluation = "deepchecks-llm-evaluation",
        .fiddler = "fiddler",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lakera_guard => "lakera-guard",
            .comet => "comet",
            .deepchecks_llm_evaluation => "deepchecks-llm-evaluation",
            .fiddler => "fiddler",
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
