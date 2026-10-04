const std = @import("std");

/// The mode for creating a ticket.
pub const TicketCreationMode = enum {
    dryrun,

    pub const json_field_names = .{
        .dryrun = "DRYRUN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dryrun => "DRYRUN",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
