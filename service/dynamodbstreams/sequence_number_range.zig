/// The beginning and ending sequence numbers for the stream records contained
/// within a shard.
pub const SequenceNumberRange = struct {
    /// The last sequence number for the stream records contained within a shard.
    /// String contains numeric characters only.
    ending_sequence_number: ?[]const u8,

    /// The first sequence number for the stream records contained within a shard.
    /// String contains numeric characters only.
    starting_sequence_number: ?[]const u8,

    pub const json_field_names = .{
        .ending_sequence_number = "EndingSequenceNumber",
        .starting_sequence_number = "StartingSequenceNumber",
    };
};
