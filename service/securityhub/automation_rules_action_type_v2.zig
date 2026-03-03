const std = @import("std");

pub const AutomationRulesActionTypeV2 = enum {
    finding_fields_update,
    external_integration,

    pub const json_field_names = .{
        .finding_fields_update = "FINDING_FIELDS_UPDATE",
        .external_integration = "EXTERNAL_INTEGRATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding_fields_update => "FINDING_FIELDS_UPDATE",
            .external_integration => "EXTERNAL_INTEGRATION",
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
