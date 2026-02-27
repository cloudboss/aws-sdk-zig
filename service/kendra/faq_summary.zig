const FaqFileFormat = @import("faq_file_format.zig").FaqFileFormat;
const FaqStatus = @import("faq_status.zig").FaqStatus;

/// Summary information for frequently asked questions and answers included in
/// an
/// index.
pub const FaqSummary = struct {
    /// The Unix timestamp when the FAQ was created.
    created_at: ?i64,

    /// The file type used to create the FAQ.
    file_format: ?FaqFileFormat,

    /// The identifier of the FAQ.
    id: ?[]const u8,

    /// The code for a language. This shows a supported language for the FAQ
    /// document
    /// as part of the summary information for FAQs. English is supported by
    /// default.
    /// For more information on supported languages, including their codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8,

    /// The name that you assigned the FAQ when you created or updated the FAQ.
    name: ?[]const u8,

    /// The current status of the FAQ. When the status is `ACTIVE` the FAQ is ready
    /// for use.
    status: ?FaqStatus,

    /// The Unix timestamp when the FAQ was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .file_format = "FileFormat",
        .id = "Id",
        .language_code = "LanguageCode",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
