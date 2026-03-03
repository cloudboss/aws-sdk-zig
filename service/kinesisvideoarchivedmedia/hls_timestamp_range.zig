/// The start and end of the timestamp range for the requested media.
///
/// This value should not be present if `PlaybackType` is
/// `LIVE`.
pub const HLSTimestampRange = struct {
    /// The end of the timestamp range for the requested media. This value must be
    /// within 24
    /// hours of the specified `StartTimestamp`, and it must be later than the
    /// `StartTimestamp` value.
    ///
    /// If `FragmentSelectorType` for the request is `SERVER_TIMESTAMP`,
    /// this value must be in the past.
    ///
    /// The `EndTimestamp` value is required for `ON_DEMAND` mode, but
    /// optional for `LIVE_REPLAY` mode. If the `EndTimestamp` is not set
    /// for `LIVE_REPLAY` mode then the session will continue to include newly
    /// ingested fragments until the session expires.
    ///
    /// This value is inclusive. The `EndTimestamp` is compared to the
    /// (starting) timestamp of the fragment. Fragments that start before the
    /// `EndTimestamp` value and continue past it are included in the
    /// session.
    end_timestamp: ?i64 = null,

    /// The start of the timestamp range for the requested media.
    ///
    /// If the `HLSTimestampRange` value is specified, the
    /// `StartTimestamp` value is required.
    ///
    /// Only fragments that start exactly at or after `StartTimestamp` are included
    /// in the session. Fragments that start before `StartTimestamp` and continue
    /// past it aren't included in the session. If `FragmentSelectorType` is
    /// `SERVER_TIMESTAMP`, the `StartTimestamp` must be later than
    /// the stream head.
    start_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .end_timestamp = "EndTimestamp",
        .start_timestamp = "StartTimestamp",
    };
};
