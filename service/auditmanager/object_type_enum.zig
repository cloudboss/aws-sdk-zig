const std = @import("std");

pub const ObjectTypeEnum = enum {
    assessment,
    control_set,
    control,
    delegation,
    assessment_report,

    pub const json_field_names = .{
        .assessment = "ASSESSMENT",
        .control_set = "CONTROL_SET",
        .control = "CONTROL",
        .delegation = "DELEGATION",
        .assessment_report = "ASSESSMENT_REPORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assessment => "ASSESSMENT",
            .control_set => "CONTROL_SET",
            .control => "CONTROL",
            .delegation => "DELEGATION",
            .assessment_report => "ASSESSMENT_REPORT",
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
