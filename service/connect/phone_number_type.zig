pub const PhoneNumberType = enum {
    toll_free,
    did,
    uifn,
    shared,
    third_party_tf,
    third_party_did,
    short_code,

    pub const json_field_names = .{
        .toll_free = "TOLL_FREE",
        .did = "DID",
        .uifn = "UIFN",
        .shared = "SHARED",
        .third_party_tf = "THIRD_PARTY_TF",
        .third_party_did = "THIRD_PARTY_DID",
        .short_code = "SHORT_CODE",
    };
};
