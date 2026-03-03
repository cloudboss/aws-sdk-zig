const std = @import("std");

/// Specify whether your DASH profile is on-demand or main. When you choose Main
/// profile, the service signals urn:mpeg:dash:profile:isoff-main:2011 in your
/// .mpd DASH manifest. When you choose On-demand, the service signals
/// urn:mpeg:dash:profile:isoff-on-demand:2011 in your .mpd. When you choose
/// On-demand, you must also set the output group setting Segment control to
/// Single file.
pub const CmafMpdProfile = enum {
    main_profile,
    on_demand_profile,

    pub const json_field_names = .{
        .main_profile = "MAIN_PROFILE",
        .on_demand_profile = "ON_DEMAND_PROFILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .main_profile => "MAIN_PROFILE",
            .on_demand_profile => "ON_DEMAND_PROFILE",
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
