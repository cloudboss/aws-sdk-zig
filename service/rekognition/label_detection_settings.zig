const GeneralLabelsSettings = @import("general_labels_settings.zig").GeneralLabelsSettings;

/// Contains the specified filters that should be applied to a list of returned
/// GENERAL_LABELS.
pub const LabelDetectionSettings = struct {
    general_labels: ?GeneralLabelsSettings = null,

    pub const json_field_names = .{
        .general_labels = "GeneralLabels",
    };
};
