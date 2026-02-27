const Directionality = @import("directionality.zig").Directionality;
const TerminologyDataFormat = @import("terminology_data_format.zig").TerminologyDataFormat;

/// The data associated with the custom terminology. For information about the
/// custom terminology file, see
/// [
/// Creating a Custom
/// Terminology](https://docs.aws.amazon.com/translate/latest/dg/creating-custom-terminology.html).
pub const TerminologyData = struct {
    /// The directionality of your terminology resource indicates whether it has one
    /// source
    /// language (uni-directional) or multiple (multi-directional).
    ///
    /// **UNI**
    ///
    /// The terminology resource has one source language (for example, the first
    /// column in a
    /// CSV file), and all of its other languages are target languages.
    ///
    /// **MULTI**
    ///
    /// Any language in the terminology resource can be the source language or a
    /// target
    /// language. A single multi-directional terminology resource can be used for
    /// jobs that
    /// translate different language pairs. For example, if the terminology contains
    /// English and
    /// Spanish terms, it can be used for jobs that translate English to Spanish and
    /// Spanish to
    /// English.
    ///
    /// When you create a custom terminology resource without specifying the
    /// directionality, it
    /// behaves as uni-directional terminology, although this parameter will have a
    /// null value.
    directionality: ?Directionality,

    /// The file containing the custom terminology data. Your version of the AWS SDK
    /// performs a
    /// Base64-encoding on this field before sending a request to the AWS service.
    /// Users of the SDK
    /// should not perform Base64-encoding themselves.
    file: []const u8,

    /// The data format of the custom terminology.
    format: TerminologyDataFormat,

    pub const json_field_names = .{
        .directionality = "Directionality",
        .file = "File",
        .format = "Format",
    };
};
