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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
