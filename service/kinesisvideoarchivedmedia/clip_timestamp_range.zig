/// The range of timestamps for which to return fragments.
pub const ClipTimestampRange = struct {
    /// The end of the timestamp range for the requested media.
    ///
    /// This value must be within 24 hours of the specified `StartTimestamp`, and
    /// it must be later than the `StartTimestamp` value. If
    /// `FragmentSelectorType` for the request is `SERVER_TIMESTAMP`,
    /// this value must be in the past.
    ///
    /// This value is inclusive. The `EndTimestamp` is compared to the (starting)
    /// timestamp of the fragment. Fragments that start before the `EndTimestamp`
    /// value and continue past it are included in the session.
    end_timestamp: i64,

    /// The starting timestamp in the range of timestamps for which to return
    /// fragments.
    ///
    /// Only fragments that start exactly at or after `StartTimestamp` are included
    /// in the session. Fragments that start before `StartTimestamp` and continue
    /// past it aren't included in the session. If `FragmentSelectorType` is
    /// `SERVER_TIMESTAMP`, the `StartTimestamp` must be later than
    /// the stream head.
    start_timestamp: i64,

    pub const json_field_names = .{
        .end_timestamp = "EndTimestamp",
        .start_timestamp = "StartTimestamp",
    };
};
