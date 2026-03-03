const std = @import("std");

pub const AvailabilityZoneOptInStatus = enum {
    opt_in_not_required,
    opted_in,
    not_opted_in,

    pub const json_field_names = .{
        .opt_in_not_required = "opt-in-not-required",
        .opted_in = "opted-in",
        .not_opted_in = "not-opted-in",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opt_in_not_required => "opt-in-not-required",
            .opted_in => "opted-in",
            .not_opted_in => "not-opted-in",
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
