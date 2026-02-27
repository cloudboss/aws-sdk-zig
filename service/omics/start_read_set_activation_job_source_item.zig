/// A source for a read set activation job.
pub const StartReadSetActivationJobSourceItem = struct {
    /// The source's read set ID.
    read_set_id: []const u8,

    pub const json_field_names = .{
        .read_set_id = "readSetId",
    };
};
