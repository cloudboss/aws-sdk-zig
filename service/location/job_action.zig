const std = @import("std");

pub const JobAction = enum {
    /// The job will perform address validation over the job's input.
    validate_address,

    pub const json_field_names = .{
        .validate_address = "ValidateAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validate_address => "ValidateAddress",
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
