const std = @import("std");

/// The type of device transfer. INCOMING for an input device that is being
/// transferred to you, OUTGOING for an input device that you are transferring
/// to another AWS account.
pub const InputDeviceTransferType = enum {
    outgoing,
    incoming,

    pub const json_field_names = .{
        .outgoing = "OUTGOING",
        .incoming = "INCOMING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .outgoing => "OUTGOING",
            .incoming => "INCOMING",
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
