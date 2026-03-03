/// An object that contains information about a blacklisting event that impacts
/// one of the
/// dedicated IP addresses that is associated with your account.
pub const BlacklistEntry = struct {
    /// Additional information about the blacklisting event, as provided by the
    /// blacklist
    /// maintainer.
    description: ?[]const u8 = null,

    /// The time when the blacklisting event occurred.
    listing_time: ?i64 = null,

    /// The name of the blacklist that the IP address appears on.
    rbl_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .listing_time = "ListingTime",
        .rbl_name = "RblName",
    };
};
