const std = @import("std");

/// The status of the action to synchronize the device configuration. If you
/// change the configuration of the input device (for example, the maximum
/// bitrate), MediaLive sends the new data to the device. The device might not
/// update itself immediately. SYNCED means the device has updated its
/// configuration. SYNCING means that it has not updated its configuration.
pub const DeviceSettingsSyncState = enum {
    synced,
    syncing,

    pub const json_field_names = .{
        .synced = "SYNCED",
        .syncing = "SYNCING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .synced => "SYNCED",
            .syncing => "SYNCING",
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
