/// The type of currency that the data for an Amazon Macie usage metric is
/// reported in. Possible values are:
pub const Currency = enum {
    usd,

    pub const json_field_names = .{
        .usd = "USD",
    };
};
