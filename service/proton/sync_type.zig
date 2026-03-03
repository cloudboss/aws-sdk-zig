const std = @import("std");

pub const SyncType = enum {
    /// Syncs environment and service templates to Proton.
    template_sync,
    /// Syncs services and service instances to Proton.
    service_sync,

    pub const json_field_names = .{
        .template_sync = "TEMPLATE_SYNC",
        .service_sync = "SERVICE_SYNC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .template_sync => "TEMPLATE_SYNC",
            .service_sync => "SERVICE_SYNC",
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
