const ContentKeyPeriodTiming = @import("content_key_period_timing.zig").ContentKeyPeriodTiming;

/// The configuration that controls the content key period timing information
/// that MediaPackage signals to your DRM key provider.
pub const ContentKeyPeriodConfiguration = struct {
    /// Specifies what timing information MediaPackage signals in the
    /// `ContentKeyPeriod` to your DRM key provider. If you don't specify a value,
    /// the default is `INDEX_ONLY`. Signaling start and end times (`START_END_ONLY`
    /// or `INDEX_WITH_START_END`) also requires key rotation to be enabled.
    ///
    /// The allowed values are:
    ///
    /// * `INDEX_ONLY` - Signals only the content key index. This is the default and
    ///   matches the current behavior. It's supported for both SPEKE Version 2.0
    ///   and 2.1.
    /// * `START_END_ONLY` - Signals only the start and end times the key is used
    ///   for. Requires `SpekeVersion` `V2_1`.
    /// * `INDEX_WITH_START_END` - Signals both the content key index and the start
    ///   and end times the key is used for. Requires `SpekeVersion` `V2_1`.
    content_key_period_timing: ?ContentKeyPeriodTiming = null,

    pub const json_field_names = .{
        .content_key_period_timing = "ContentKeyPeriodTiming",
    };
};
