const std = @import("std");

pub const ValidationExceptionReason = enum {
    api_does_not_support_labeled_arns,
    missing_required_parameter,
    cannot_update_completed_map_run,
    invalid_routing_configuration,

    pub const json_field_names = .{
        .api_does_not_support_labeled_arns = "API_DOES_NOT_SUPPORT_LABELED_ARNS",
        .missing_required_parameter = "MISSING_REQUIRED_PARAMETER",
        .cannot_update_completed_map_run = "CANNOT_UPDATE_COMPLETED_MAP_RUN",
        .invalid_routing_configuration = "INVALID_ROUTING_CONFIGURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_does_not_support_labeled_arns => "API_DOES_NOT_SUPPORT_LABELED_ARNS",
            .missing_required_parameter => "MISSING_REQUIRED_PARAMETER",
            .cannot_update_completed_map_run => "CANNOT_UPDATE_COMPLETED_MAP_RUN",
            .invalid_routing_configuration => "INVALID_ROUTING_CONFIGURATION",
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
