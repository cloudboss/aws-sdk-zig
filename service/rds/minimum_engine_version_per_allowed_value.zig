/// The minimum DB engine version required for each corresponding allowed value
/// for an option setting.
pub const MinimumEngineVersionPerAllowedValue = struct {
    /// The allowed value for an option setting.
    allowed_value: ?[]const u8,

    /// The minimum DB engine version required for the allowed value.
    minimum_engine_version: ?[]const u8,
};
