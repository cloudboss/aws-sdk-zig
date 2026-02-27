/// The information for an opted out number in an Amazon Web Services account.
pub const OptedOutNumberInformation = struct {
    /// This is set to true if it was the end recipient that opted out.
    end_user_opted_out: bool = false,

    /// The phone number that is opted out.
    opted_out_number: []const u8,

    /// The time that the op tout occurred, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    opted_out_timestamp: i64,

    pub const json_field_names = .{
        .end_user_opted_out = "EndUserOptedOut",
        .opted_out_number = "OptedOutNumber",
        .opted_out_timestamp = "OptedOutTimestamp",
    };
};
