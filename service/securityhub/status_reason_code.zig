const std = @import("std");

pub const StatusReasonCode = enum {
    no_available_configuration_recorder,
    maximum_number_of_config_rules_exceeded,
    no_available_multicloud_connector,
    internal_error,

    pub const json_field_names = .{
        .no_available_configuration_recorder = "NO_AVAILABLE_CONFIGURATION_RECORDER",
        .maximum_number_of_config_rules_exceeded = "MAXIMUM_NUMBER_OF_CONFIG_RULES_EXCEEDED",
        .no_available_multicloud_connector = "NO_AVAILABLE_MULTICLOUD_CONNECTOR",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_available_configuration_recorder => "NO_AVAILABLE_CONFIGURATION_RECORDER",
            .maximum_number_of_config_rules_exceeded => "MAXIMUM_NUMBER_OF_CONFIG_RULES_EXCEEDED",
            .no_available_multicloud_connector => "NO_AVAILABLE_MULTICLOUD_CONNECTOR",
            .internal_error => "INTERNAL_ERROR",
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
