const aws = @import("aws");

const UnlabeledEventsTreatment = @import("unlabeled_events_treatment.zig").UnlabeledEventsTreatment;

/// The label schema.
pub const LabelSchema = struct {
    /// The label mapper maps the Amazon Fraud Detector supported model
    /// classification labels (`FRAUD`, `LEGIT`) to the appropriate event type
    /// labels. For example, if "`FRAUD`" and "`LEGIT`" are Amazon Fraud Detector
    /// supported labels, this mapper could be: `{"FRAUD" => ["0"]`, `"LEGIT" =>
    /// ["1"]}` or `{"FRAUD" => ["false"]`, `"LEGIT" => ["true"]}` or `{"FRAUD" =>
    /// ["fraud", "abuse"]`, `"LEGIT" => ["legit", "safe"]}`. The value part of the
    /// mapper is a list, because you may have multiple label variants from your
    /// event type for a single Amazon Fraud Detector label.
    label_mapper: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The action to take for unlabeled events.
    ///
    /// * Use `IGNORE` if you want the unlabeled events to be ignored. This is
    ///   recommended when the majority of the events in the dataset are labeled.
    ///
    /// * Use `FRAUD` if you want to categorize all unlabeled events as “Fraud”.
    ///   This is recommended when most of the events in your dataset are
    ///   fraudulent.
    ///
    /// * Use `LEGIT` if you want to categorize all unlabeled events as “Legit”.
    ///   This is recommended when most of the events in your dataset are
    ///   legitimate.
    ///
    /// * Use `AUTO` if you want Amazon Fraud Detector to decide how to use the
    ///   unlabeled data. This is recommended when there is significant unlabeled
    ///   events in the dataset.
    ///
    /// By default, Amazon Fraud Detector ignores the unlabeled data.
    unlabeled_events_treatment: ?UnlabeledEventsTreatment = null,

    pub const json_field_names = .{
        .label_mapper = "labelMapper",
        .unlabeled_events_treatment = "unlabeledEventsTreatment",
    };
};
