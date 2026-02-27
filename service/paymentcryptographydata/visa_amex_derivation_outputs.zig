/// The attributes values used for Amex and Visa derivation methods.
pub const VisaAmexDerivationOutputs = struct {
    /// The `keyArn` of the issuer master key for cryptogram (IMK-AC) used by the
    /// operation.
    authorization_request_key_arn: []const u8,

    /// The key check value (KCV) of the issuer master key for cryptogram (IMK-AC)
    /// used by the operation.
    authorization_request_key_check_value: []const u8,

    /// The `keyArn` of the current PIN PEK.
    current_pin_pek_arn: ?[]const u8,

    /// The key check value (KCV) of the current PIN PEK.
    current_pin_pek_key_check_value: ?[]const u8,

    pub const json_field_names = .{
        .authorization_request_key_arn = "AuthorizationRequestKeyArn",
        .authorization_request_key_check_value = "AuthorizationRequestKeyCheckValue",
        .current_pin_pek_arn = "CurrentPinPekArn",
        .current_pin_pek_key_check_value = "CurrentPinPekKeyCheckValue",
    };
};
