const std = @import("std");

pub const RecorderStatus = enum {
    pending,
    success,
    failure,
    not_applicable,

    pub const json_field_names = .{
        .pending = "Pending",
        .success = "Success",
        .failure = "Failure",
        .not_applicable = "NotApplicable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .success => "Success",
            .failure => "Failure",
            .not_applicable => "NotApplicable",
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
