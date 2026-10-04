const std = @import("std");

pub const ModelRegistrationMode = enum {
    auto_model_registration_enabled,
    auto_model_registration_disabled,

    pub const json_field_names = .{
        .auto_model_registration_enabled = "AutoModelRegistrationEnabled",
        .auto_model_registration_disabled = "AutoModelRegistrationDisabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_model_registration_enabled => "AutoModelRegistrationEnabled",
            .auto_model_registration_disabled => "AutoModelRegistrationDisabled",
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
