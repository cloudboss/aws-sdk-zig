/// Defines a range of sequence numbers within a change data capture stream's
/// shard for Amazon Keyspaces.
pub const SequenceNumberRange = struct {
    /// The ending sequence number of the range, which may be null for open-ended
    /// ranges.
    ending_sequence_number: ?[]const u8 = null,

    /// The starting sequence number of the range.
    starting_sequence_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .ending_sequence_number = "endingSequenceNumber",
        .starting_sequence_number = "startingSequenceNumber",
    };
};
