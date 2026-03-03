/// The container for time.
pub const BlockchainInstant = struct {
    /// The container of the `Timestamp` of the blockchain instant.
    ///
    /// This `timestamp` will only be recorded up to
    /// the second.
    time: ?i64 = null,

    pub const json_field_names = .{
        .time = "time",
    };
};
