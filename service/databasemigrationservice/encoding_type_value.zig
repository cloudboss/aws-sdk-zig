pub const EncodingTypeValue = enum {
    plain,
    plain_dictionary,
    rle_dictionary,

    pub const json_field_names = .{
        .plain = "PLAIN",
        .plain_dictionary = "PLAIN_DICTIONARY",
        .rle_dictionary = "RLE_DICTIONARY",
    };
};
