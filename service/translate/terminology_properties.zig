const Directionality = @import("directionality.zig").Directionality;
const EncryptionKey = @import("encryption_key.zig").EncryptionKey;
const TerminologyDataFormat = @import("terminology_data_format.zig").TerminologyDataFormat;

/// The properties of the custom terminology.
pub const TerminologyProperties = struct {
    /// The Amazon Resource Name (ARN) of the custom terminology.
    arn: ?[]const u8,

    /// The time at which the custom terminology was created, based on the
    /// timestamp.
    created_at: ?i64,

    /// The description of the custom terminology properties.
    description: ?[]const u8,

    /// The directionality of your terminology resource indicates whether it has one
    /// source
    /// language (uni-directional) or multiple (multi-directional).
    ///
    /// **UNI**
    ///
    /// The terminology resource has one source language (the first column in a CSV
    /// file),
    /// and all of its other languages are target languages.
    ///
    /// **MULTI**
    ///
    /// Any language in the terminology resource can be the source language.
    directionality: ?Directionality,

    /// The encryption key for the custom terminology.
    encryption_key: ?EncryptionKey,

    /// The format of the custom terminology input file.
    format: ?TerminologyDataFormat,

    /// The time at which the custom terminology was last update, based on the
    /// timestamp.
    last_updated_at: ?i64,

    /// Additional information from Amazon Translate about the terminology resource.
    message: ?[]const u8,

    /// The name of the custom terminology.
    name: ?[]const u8,

    /// The size of the file used when importing a custom terminology.
    size_bytes: ?i32,

    /// The number of terms in the input file that Amazon Translate skipped when you
    /// created or
    /// updated the terminology resource.
    skipped_term_count: ?i32,

    /// The language code for the source text of the translation request for which
    /// the custom
    /// terminology is being used.
    source_language_code: ?[]const u8,

    /// The language codes for the target languages available with the custom
    /// terminology
    /// resource. All possible target languages are returned in array.
    target_language_codes: ?[]const []const u8,

    /// The number of terms included in the custom terminology.
    term_count: ?i32,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .directionality = "Directionality",
        .encryption_key = "EncryptionKey",
        .format = "Format",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .name = "Name",
        .size_bytes = "SizeBytes",
        .skipped_term_count = "SkippedTermCount",
        .source_language_code = "SourceLanguageCode",
        .target_language_codes = "TargetLanguageCodes",
        .term_count = "TermCount",
    };
};
