/// The range of possible sequence numbers for the shard.
pub const SequenceNumberRange = struct {
    /// The ending sequence number for the range. Shards that are in the OPEN state
    /// have an
    /// ending sequence number of `null`.
    ending_sequence_number: ?[]const u8 = null,

    /// The starting sequence number for the range.
    starting_sequence_number: []const u8,

    pub const json_field_names = .{
        .ending_sequence_number = "EndingSequenceNumber",
        .starting_sequence_number = "StartingSequenceNumber",
    };
};
