const std = @import("std");

pub const RiskDecisionType = enum {
    no_risk,
    account_takeover,
    block,

    pub const json_field_names = .{
        .no_risk = "NoRisk",
        .account_takeover = "AccountTakeover",
        .block = "Block",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_risk => "NoRisk",
            .account_takeover => "AccountTakeover",
            .block => "Block",
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
