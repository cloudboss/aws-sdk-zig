const std = @import("std");

pub const IndexEdition = enum {
    developer_edition,
    enterprise_edition,
    gen_ai_enterprise_edition,

    pub const json_field_names = .{
        .developer_edition = "DEVELOPER_EDITION",
        .enterprise_edition = "ENTERPRISE_EDITION",
        .gen_ai_enterprise_edition = "GEN_AI_ENTERPRISE_EDITION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .developer_edition => "DEVELOPER_EDITION",
            .enterprise_edition => "ENTERPRISE_EDITION",
            .gen_ai_enterprise_edition => "GEN_AI_ENTERPRISE_EDITION",
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
