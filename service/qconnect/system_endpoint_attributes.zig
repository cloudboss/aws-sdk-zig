/// The system endpoint attributes that are used with the message template.
pub const SystemEndpointAttributes = struct {
    /// The customer's phone number if used with `customerEndpoint`, or the number
    /// the customer dialed to call your contact center if used with
    /// `systemEndpoint`.
    address: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "address",
    };
};
