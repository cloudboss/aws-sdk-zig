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
};
