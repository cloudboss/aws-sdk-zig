const std = @import("std");

/// Optionally remove any tts:rubyReserve attributes present in your input, that
/// do not have a tts:ruby attribute in the same element, from your output. Use
/// if your vertical Japanese output captions have alignment issues. To remove
/// ruby reserve attributes when present: Choose Enabled. To not remove any ruby
/// reserve attributes: Keep the default value, Disabled.
pub const RemoveRubyReserveAttributes = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
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
