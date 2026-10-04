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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
