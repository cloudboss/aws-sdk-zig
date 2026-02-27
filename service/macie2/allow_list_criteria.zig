const S3WordsList = @import("s3_words_list.zig").S3WordsList;

/// Specifies the criteria for an allow list. The criteria must specify a
/// regular expression (regex) or an S3 object (s3WordsList). It can't specify
/// both.
pub const AllowListCriteria = struct {
    /// The regular expression (*regex*) that defines the text pattern to ignore.
    /// The expression can contain as many as 512 characters.
    regex: ?[]const u8,

    /// The location and name of the S3 object that lists specific text to ignore.
    s_3_words_list: ?S3WordsList,

    pub const json_field_names = .{
        .regex = "regex",
        .s_3_words_list = "s3WordsList",
    };
};
