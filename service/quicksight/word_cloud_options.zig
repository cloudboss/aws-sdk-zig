const WordCloudCloudLayout = @import("word_cloud_cloud_layout.zig").WordCloudCloudLayout;
const WordCloudWordCasing = @import("word_cloud_word_casing.zig").WordCloudWordCasing;
const WordCloudWordOrientation = @import("word_cloud_word_orientation.zig").WordCloudWordOrientation;
const WordCloudWordPadding = @import("word_cloud_word_padding.zig").WordCloudWordPadding;
const WordCloudWordScaling = @import("word_cloud_word_scaling.zig").WordCloudWordScaling;

/// The word cloud options for a word cloud visual.
pub const WordCloudOptions = struct {
    /// The cloud layout options (fluid, normal) of a word cloud.
    cloud_layout: ?WordCloudCloudLayout,

    /// The length limit of each word from 1-100.
    maximum_string_length: ?i32,

    /// The word casing options (lower_case, existing_case) for the words in a word
    /// cloud.
    word_casing: ?WordCloudWordCasing,

    /// The word orientation options (horizontal, horizontal_and_vertical) for the
    /// words in a word cloud.
    word_orientation: ?WordCloudWordOrientation,

    /// The word padding options (none, small, medium, large) for the words in a
    /// word cloud.
    word_padding: ?WordCloudWordPadding,

    /// The word scaling options (emphasize, normal) for the words in a word cloud.
    word_scaling: ?WordCloudWordScaling,

    pub const json_field_names = .{
        .cloud_layout = "CloudLayout",
        .maximum_string_length = "MaximumStringLength",
        .word_casing = "WordCasing",
        .word_orientation = "WordOrientation",
        .word_padding = "WordPadding",
        .word_scaling = "WordScaling",
    };
};
