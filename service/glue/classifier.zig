const CsvClassifier = @import("csv_classifier.zig").CsvClassifier;
const GrokClassifier = @import("grok_classifier.zig").GrokClassifier;
const JsonClassifier = @import("json_classifier.zig").JsonClassifier;
const XMLClassifier = @import("xml_classifier.zig").XMLClassifier;

/// Classifiers are triggered during a crawl task. A classifier checks whether a
/// given file is
/// in a format it can handle. If it is, the classifier creates a schema in the
/// form of a
/// `StructType` object that matches that data format.
///
/// You can use the standard classifiers that Glue provides, or you can write
/// your own
/// classifiers to best categorize your data sources and specify the appropriate
/// schemas to use
/// for them. A classifier can be a `grok` classifier, an `XML` classifier,
/// a `JSON` classifier, or a custom `CSV` classifier, as specified in one
/// of the fields in the `Classifier` object.
pub const Classifier = struct {
    /// A classifier for comma-separated values (CSV).
    csv_classifier: ?CsvClassifier,

    /// A classifier that uses `grok`.
    grok_classifier: ?GrokClassifier,

    /// A classifier for JSON content.
    json_classifier: ?JsonClassifier,

    /// A classifier for XML content.
    xml_classifier: ?XMLClassifier,

    pub const json_field_names = .{
        .csv_classifier = "CsvClassifier",
        .grok_classifier = "GrokClassifier",
        .json_classifier = "JsonClassifier",
        .xml_classifier = "XMLClassifier",
    };
};
