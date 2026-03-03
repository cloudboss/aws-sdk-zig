const std = @import("std");

pub const LicenseType = enum {
    /// Grafana Enterprise License.
    enterprise,
    /// Grafana Enterprise Free Trial License.
    enterprise_free_trial,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .enterprise_free_trial = "ENTERPRISE_FREE_TRIAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enterprise => "ENTERPRISE",
            .enterprise_free_trial => "ENTERPRISE_FREE_TRIAL",
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
