const Operator = @import("operator.zig").Operator;

/// MediaTailor only places (consumes) prefetched ads if the ad break meets the
/// criteria defined by the dynamic variables. This gives you granular control
/// over which ad break to place the prefetched ads into.
///
/// As an example, let's say that you set `DynamicVariable` to `scte.event_id`
/// and `Operator` to `EQUALS`, and your playback configuration has an ADS URL
/// of
/// `https://my.ads.server.com/path?&podId=[scte.avail_num]&event=[scte.event_id]&duration=[session.avail_duration_secs]`. And the prefetch request to the ADS contains these values `https://my.ads.server.com/path?&podId=3&event=my-awesome-event&duration=30`. MediaTailor will only insert the prefetched ads into the ad break if has a SCTE marker with an event id of `my-awesome-event`, since it must match the event id that MediaTailor uses to query the ADS.
///
/// You can specify up to five `AvailMatchingCriteria`. If you specify multiple
/// `AvailMatchingCriteria`, MediaTailor combines them to match using a logical
/// `AND`. You can model logical `OR` combinations by creating multiple prefetch
/// schedules.
pub const AvailMatchingCriteria = struct {
    /// The dynamic variable(s) that MediaTailor should use as avail matching
    /// criteria. MediaTailor only places the prefetched ads into the avail if the
    /// avail matches the criteria defined by the dynamic variable. For information
    /// about dynamic variables, see [Using dynamic ad
    /// variables](https://docs.aws.amazon.com/mediatailor/latest/ug/variables.html)
    /// in the *MediaTailor User Guide*.
    ///
    /// You can include up to 100 dynamic variables.
    dynamic_variable: []const u8,

    /// For the `DynamicVariable` specified in `AvailMatchingCriteria`, the Operator
    /// that is used for the comparison.
    operator: Operator,

    pub const json_field_names = .{
        .dynamic_variable = "DynamicVariable",
        .operator = "Operator",
    };
};
