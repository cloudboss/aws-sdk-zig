const std = @import("std");

/// By default, the service terminates any unterminated captions at the end of
/// each input. If you want the caption to continue onto your next input,
/// disable this setting.
pub const AncillaryTerminateCaptions = enum {
    end_of_input,
    disabled,

    pub const json_field_names = .{
        .end_of_input = "END_OF_INPUT",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end_of_input => "END_OF_INPUT",
            .disabled => "DISABLED",
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
