const std = @import("std");

/// The unit of measurement for the contract duration value. Currently accepts
/// only `Months`.
pub const ExpectedContractDurationTerm = enum {
    months,

    pub const json_field_names = .{
        .months = "Months",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .months => "Months",
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
