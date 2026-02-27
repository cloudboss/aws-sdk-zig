/// Information about the MAC Security (MACsec) secret key.
pub const MacSecKey = struct {
    /// The Connection Key Name (CKN) for the MAC Security secret key.
    ckn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the MAC Security (MACsec) secret key.
    secret_arn: ?[]const u8,

    /// The date that the MAC Security (MACsec) secret key takes effect. The value
    /// is displayed in UTC format.
    start_on: ?[]const u8,

    /// The state of the MAC Security (MACsec) secret key.
    ///
    /// The possible values are:
    ///
    /// * `associating`: The MAC Security (MACsec) secret key is being validated and
    ///   not yet associated with the connection or LAG.
    ///
    /// * `associated`: The MAC Security (MACsec) secret key is validated and
    ///   associated with the connection or LAG.
    ///
    /// * `disassociating`: The MAC Security (MACsec) secret key is being
    ///   disassociated from the connection or LAG
    ///
    /// * `disassociated`: The MAC Security (MACsec) secret key is no longer
    ///   associated with the connection or LAG.
    state: ?[]const u8,

    pub const json_field_names = .{
        .ckn = "ckn",
        .secret_arn = "secretARN",
        .start_on = "startOn",
        .state = "state",
    };
};
