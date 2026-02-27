const MatchedRecord = @import("matched_record.zig").MatchedRecord;

/// The match group.
pub const MatchGroup = struct {
    /// The match ID.
    match_id: []const u8,

    /// The match rule of the match group.
    match_rule: []const u8,

    /// The matched records.
    records: []const MatchedRecord,

    pub const json_field_names = .{
        .match_id = "matchId",
        .match_rule = "matchRule",
        .records = "records",
    };
};
