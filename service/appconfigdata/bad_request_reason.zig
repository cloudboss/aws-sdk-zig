const std = @import("std");

pub const BadRequestReason = enum {
    /// Indicates there was a problem with one or more of the parameters.
    /// See InvalidParameters in the BadRequestDetails for more information.
    invalid_parameters,

    pub const json_field_names = .{
        .invalid_parameters = "InvalidParameters",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_parameters => "InvalidParameters",
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
