const std = @import("std");

pub const TrustDirection = enum {
    one_way_outgoing,
    one_way_incoming,
    two_way,

    pub const json_field_names = .{
        .one_way_outgoing = "One-Way: Outgoing",
        .one_way_incoming = "One-Way: Incoming",
        .two_way = "Two-Way",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_way_outgoing => "One-Way: Outgoing",
            .one_way_incoming => "One-Way: Incoming",
            .two_way => "Two-Way",
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
