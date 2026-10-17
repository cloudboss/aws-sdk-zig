const std = @import("std");

/// The action to apply to an existing record expiry (long-term memory
/// time-to-live) configuration. `REMOVE` removes a previously configured expiry
/// so that the records no longer expire.
pub const RecordExpiryAction = enum {
    remove,

    pub const json_field_names = .{
        .remove = "REMOVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .remove => "REMOVE",
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
