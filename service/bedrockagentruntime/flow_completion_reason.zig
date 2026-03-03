const std = @import("std");

pub const FlowCompletionReason = enum {
    success,
    input_required,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .input_required = "INPUT_REQUIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .input_required => "INPUT_REQUIRED",
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
