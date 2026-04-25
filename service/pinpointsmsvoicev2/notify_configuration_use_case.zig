const std = @import("std");

/// The use case for a notify configuration.
///
/// * `CODE_VERIFICATION` - Code verification use case.
pub const NotifyConfigurationUseCase = enum {
    code_verification,

    pub const json_field_names = .{
        .code_verification = "CODE_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .code_verification => "CODE_VERIFICATION",
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
