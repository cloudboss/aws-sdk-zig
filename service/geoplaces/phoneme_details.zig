const AddressComponentPhonemes = @import("address_component_phonemes.zig").AddressComponentPhonemes;
const PhonemeTranscription = @import("phoneme_transcription.zig").PhonemeTranscription;

/// The phoneme details.
pub const PhonemeDetails = struct {
    /// How to pronounce the address.
    address: ?AddressComponentPhonemes = null,

    /// List of `PhonemeTranscription`. See `PhonemeTranscription` for fields.
    title: ?[]const PhonemeTranscription = null,

    pub const json_field_names = .{
        .address = "Address",
        .title = "Title",
    };
};
