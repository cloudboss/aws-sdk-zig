const std = @import("std");

pub const ReportInstanceReasonCodes = enum {
    instance_stuck_in_state,
    unresponsive,
    not_accepting_credentials,
    password_not_available,
    performance_network,
    performance_instance_store,
    performance_ebs_volume,
    performance_other,
    other,

    pub const json_field_names = .{
        .instance_stuck_in_state = "instance-stuck-in-state",
        .unresponsive = "unresponsive",
        .not_accepting_credentials = "not-accepting-credentials",
        .password_not_available = "password-not-available",
        .performance_network = "performance-network",
        .performance_instance_store = "performance-instance-store",
        .performance_ebs_volume = "performance-ebs-volume",
        .performance_other = "performance-other",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_stuck_in_state => "instance-stuck-in-state",
            .unresponsive => "unresponsive",
            .not_accepting_credentials => "not-accepting-credentials",
            .password_not_available => "password-not-available",
            .performance_network => "performance-network",
            .performance_instance_store => "performance-instance-store",
            .performance_ebs_volume => "performance-ebs-volume",
            .performance_other => "performance-other",
            .other => "other",
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
