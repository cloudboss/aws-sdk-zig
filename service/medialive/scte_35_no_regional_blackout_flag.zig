const std = @import("std");

/// Corresponds to the no_regional_blackout_flag parameter. A value of
/// REGIONAL_BLACKOUT corresponds to 0 (false) in the SCTE-35 specification. If
/// you include one of the "restriction" flags then you must include all four of
/// them.
pub const Scte35NoRegionalBlackoutFlag = enum {
    regional_blackout,
    no_regional_blackout,

    pub const json_field_names = .{
        .regional_blackout = "REGIONAL_BLACKOUT",
        .no_regional_blackout = "NO_REGIONAL_BLACKOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .regional_blackout => "REGIONAL_BLACKOUT",
            .no_regional_blackout => "NO_REGIONAL_BLACKOUT",
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
