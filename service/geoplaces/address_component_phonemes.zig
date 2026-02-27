const PhonemeTranscription = @import("phoneme_transcription.zig").PhonemeTranscription;

/// How to pronounce the various components of the address or place.
pub const AddressComponentPhonemes = struct {
    /// How to pronounce the name of the block.
    block: ?[]const PhonemeTranscription,

    /// The alpha-2 or alpha-3 character code for the country that the results will
    /// be present in.
    country: ?[]const PhonemeTranscription,

    /// How to pronounce the district or division of a city results should be
    /// present in.
    district: ?[]const PhonemeTranscription,

    /// How to pronounce the city or locality results should be present in.
    ///
    /// Example: `Vancouver`.
    locality: ?[]const PhonemeTranscription,

    /// How to pronounce the region or state results should be to be present in.
    region: ?[]const PhonemeTranscription,

    /// How to pronounce the name of the street results should be present in.
    street: ?[]const PhonemeTranscription,

    /// How to pronounce the name of the sub-block.
    sub_block: ?[]const PhonemeTranscription,

    /// How to pronounce the sub-district or division of a city results should be
    /// present in.
    sub_district: ?[]const PhonemeTranscription,

    /// How to pronounce the sub-region or county for which results should be
    /// present in.
    sub_region: ?[]const PhonemeTranscription,

    pub const json_field_names = .{
        .block = "Block",
        .country = "Country",
        .district = "District",
        .locality = "Locality",
        .region = "Region",
        .street = "Street",
        .sub_block = "SubBlock",
        .sub_district = "SubDistrict",
        .sub_region = "SubRegion",
    };
};
