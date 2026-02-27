/// The refresh status of a Trusted Advisor check.
pub const TrustedAdvisorCheckRefreshStatus = struct {
    /// The unique identifier for the Trusted Advisor check.
    check_id: []const u8,

    /// The amount of time, in milliseconds, until the Trusted Advisor check is
    /// eligible for
    /// refresh.
    millis_until_next_refreshable: i64 = 0,

    /// The status of the Trusted Advisor check for which a refresh has been
    /// requested:
    ///
    /// * `none` - The check is not refreshed or the non-success
    /// status exceeds the timeout
    ///
    /// * `enqueued` - The check refresh requests has entered the
    /// refresh queue
    ///
    /// * `processing` - The check refresh request is picked up by the
    /// rule processing engine
    ///
    /// * `success` - The check is successfully refreshed
    ///
    /// * `abandoned` - The check refresh has failed
    status: []const u8,

    pub const json_field_names = .{
        .check_id = "checkId",
        .millis_until_next_refreshable = "millisUntilNextRefreshable",
        .status = "status",
    };
};
