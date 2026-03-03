const std = @import("std");

pub const CaptureMode = enum {
    input,
    output,
    input_and_output,

    pub const json_field_names = .{
        .input = "Input",
        .output = "Output",
        .input_and_output = "InputAndOutput",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input => "Input",
            .output => "Output",
            .input_and_output => "InputAndOutput",
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
