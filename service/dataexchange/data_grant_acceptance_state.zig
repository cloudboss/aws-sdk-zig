const std = @import("std");

pub const DataGrantAcceptanceState = enum {
    pending_receiver_acceptance,
    accepted,

    pub const json_field_names = .{
        .pending_receiver_acceptance = "PENDING_RECEIVER_ACCEPTANCE",
        .accepted = "ACCEPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_receiver_acceptance => "PENDING_RECEIVER_ACCEPTANCE",
            .accepted => "ACCEPTED",
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
