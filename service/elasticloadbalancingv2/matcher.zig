/// The codes to use when checking for a successful response from a target. If
/// the protocol
/// version is gRPC, these are gRPC codes. Otherwise, these are HTTP codes.
pub const Matcher = struct {
    /// You can specify values between 0 and 99. You can specify multiple values
    /// (for example,
    /// "0,1") or a range of values (for example, "0-5"). The default value is 12.
    grpc_code: ?[]const u8,

    /// For Application Load Balancers, you can specify values between 200 and 499,
    /// with the
    /// default value being 200. You can specify multiple values (for example,
    /// "200,202") or a range of values (for example, "200-299").
    ///
    /// For Network Load Balancers, you can specify values between 200 and 599, with
    /// the
    /// default value being 200-399. You can specify multiple values (for example,
    /// "200,202") or a range of values (for example, "200-299").
    ///
    /// For Gateway Load Balancers, this must be "200–399".
    ///
    /// Note that when using shorthand syntax, some values such as commas need to be
    /// escaped.
    http_code: ?[]const u8,
};
