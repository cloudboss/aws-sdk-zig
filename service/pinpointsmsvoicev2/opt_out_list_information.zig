/// The information for all OptOutList in an Amazon Web Services account.
pub const OptOutListInformation = struct {
    /// The time when the OutOutList was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The Amazon Resource Name (ARN) of the OptOutList.
    opt_out_list_arn: []const u8,

    /// The name of the OptOutList.
    opt_out_list_name: []const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .opt_out_list_arn = "OptOutListArn",
        .opt_out_list_name = "OptOutListName",
    };
};
