const std = @import("std");

pub const ConfigRuleState = enum {
    active,
    deleting,
    deleting_results,
    evaluating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleting_results = "DELETING_RESULTS",
        .evaluating = "EVALUATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .deleting => "DELETING",
            .deleting_results => "DELETING_RESULTS",
            .evaluating => "EVALUATING",
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
