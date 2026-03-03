const std = @import("std");

/// To create assets that have the same TIC values in each audio track, keep the
/// default value Share TICs. To create assets that have unique TIC values for
/// each audio track, choose Use unique TICs.
pub const NielsenUniqueTicPerAudioTrackType = enum {
    reserve_unique_tics_per_track,
    same_tics_per_track,

    pub const json_field_names = .{
        .reserve_unique_tics_per_track = "RESERVE_UNIQUE_TICS_PER_TRACK",
        .same_tics_per_track = "SAME_TICS_PER_TRACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reserve_unique_tics_per_track => "RESERVE_UNIQUE_TICS_PER_TRACK",
            .same_tics_per_track => "SAME_TICS_PER_TRACK",
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
