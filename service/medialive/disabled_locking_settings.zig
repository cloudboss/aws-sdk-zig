/// Disabled Locking Settings
pub const DisabledLockingSettings = struct {
    /// Optional. Only applies to CMAF Ingest Output Group and MediaPackage V2
    /// Output Group. Enter a value here to use a custom epoch, instead of the
    /// standard epoch (which started at 1970-01-01T00:00:00 UTC). Specify the start
    /// time of the custom epoch, in YYYY-MM-DDTHH:MM:SS in UTC. The time must be
    /// 2000-01-01T00:00:00 or later. Always set the MM:SS portion to 00:00.
    custom_epoch: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_epoch = "CustomEpoch",
    };
};
