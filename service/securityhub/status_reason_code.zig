const std = @import("std");

pub const StatusReasonCode = enum {
    no_available_configuration_recorder,
    maximum_number_of_config_rules_exceeded,
    internal_error,

    pub const json_field_names = .{
        .no_available_configuration_recorder = "NO_AVAILABLE_CONFIGURATION_RECORDER",
        .maximum_number_of_config_rules_exceeded = "MAXIMUM_NUMBER_OF_CONFIG_RULES_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_available_configuration_recorder => "NO_AVAILABLE_CONFIGURATION_RECORDER",
            .maximum_number_of_config_rules_exceeded => "MAXIMUM_NUMBER_OF_CONFIG_RULES_EXCEEDED",
            .internal_error => "INTERNAL_ERROR",
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
