const std = @import("std");

pub const AutomationRulesActionType = enum {
    finding_fields_update,

    pub const json_field_names = .{
        .finding_fields_update = "FINDING_FIELDS_UPDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding_fields_update => "FINDING_FIELDS_UPDATE",
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
