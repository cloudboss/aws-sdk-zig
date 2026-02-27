/// To insert ID3 tags in your output, specify two values. Use ID3 tag to
/// specify the base 64 encoded string and use Timecode to specify the time when
/// the tag should be inserted. To insert multiple ID3 tags in your output,
/// create multiple instances of ID3 insertion.
pub const Id3Insertion = struct {
    /// Use ID3 tag to provide a fully formed ID3 tag in base64-encode format.
    id_3: ?[]const u8,

    /// Provide a Timecode in HH:MM:SS:FF or HH:MM:SS;FF format.
    timecode: ?[]const u8,

    pub const json_field_names = .{
        .id_3 = "Id3",
        .timecode = "Timecode",
    };
};
