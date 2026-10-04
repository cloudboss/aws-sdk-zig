const std = @import("std");

/// The status of a delete request for an instrumentation configuration. The
/// value is `DELETED` after a successful deletion.
pub const DynamicInstrumentationDeletionStatus = enum {
    deleted,

    pub const json_field_names = .{
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deleted => "DELETED",
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
