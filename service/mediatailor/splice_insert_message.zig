/// Splice insert message configuration.
pub const SpliceInsertMessage = struct {
    /// This is written to `splice_insert.avail_num`, as defined in section 9.7.3.1
    /// of the SCTE-35 specification. The default value is `0`. Values must be
    /// between `0` and `256`, inclusive.
    avail_num: ?i32,

    /// This is written to `splice_insert.avails_expected`, as defined in section
    /// 9.7.3.1 of the SCTE-35 specification. The default value is `0`. Values must
    /// be between `0` and `256`, inclusive.
    avails_expected: ?i32,

    /// This is written to `splice_insert.splice_event_id`, as defined in section
    /// 9.7.3.1 of the SCTE-35 specification. The default value is `1`.
    splice_event_id: ?i32,

    /// This is written to `splice_insert.unique_program_id`, as defined in section
    /// 9.7.3.1 of the SCTE-35 specification. The default value is `0`. Values must
    /// be between `0` and `256`, inclusive.
    unique_program_id: ?i32,

    pub const json_field_names = .{
        .avail_num = "AvailNum",
        .avails_expected = "AvailsExpected",
        .splice_event_id = "SpliceEventId",
        .unique_program_id = "UniqueProgramId",
    };
};
