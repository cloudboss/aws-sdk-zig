const std = @import("std");

pub const BPAStatusMessage = enum {
    defaulted_for_slr_missing,
    sync_on_hold,
    defaulted_for_slr_missing_on_hold,
    unknown,

    pub const json_field_names = .{
        .defaulted_for_slr_missing = "DEFAULTED_FOR_SLR_MISSING",
        .sync_on_hold = "SYNC_ON_HOLD",
        .defaulted_for_slr_missing_on_hold = "DEFAULTED_FOR_SLR_MISSING_ON_HOLD",
        .unknown = "Unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .defaulted_for_slr_missing => "DEFAULTED_FOR_SLR_MISSING",
            .sync_on_hold => "SYNC_ON_HOLD",
            .defaulted_for_slr_missing_on_hold => "DEFAULTED_FOR_SLR_MISSING_ON_HOLD",
            .unknown => "Unknown",
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
