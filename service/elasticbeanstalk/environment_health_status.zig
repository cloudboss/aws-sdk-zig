const std = @import("std");

pub const EnvironmentHealthStatus = enum {
    no_data,
    unknown,
    pending,
    ok,
    info,
    warning,
    degraded,
    severe,
    suspended,

    pub const json_field_names = .{
        .no_data = "NoData",
        .unknown = "Unknown",
        .pending = "Pending",
        .ok = "Ok",
        .info = "Info",
        .warning = "Warning",
        .degraded = "Degraded",
        .severe = "Severe",
        .suspended = "Suspended",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_data => "NoData",
            .unknown => "Unknown",
            .pending => "Pending",
            .ok => "Ok",
            .info => "Info",
            .warning => "Warning",
            .degraded => "Degraded",
            .severe => "Severe",
            .suspended => "Suspended",
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
