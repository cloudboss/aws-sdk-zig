const GeneralLabelsSettings = @import("general_labels_settings.zig").GeneralLabelsSettings;
const DetectLabelsImagePropertiesSettings = @import("detect_labels_image_properties_settings.zig").DetectLabelsImagePropertiesSettings;

/// Settings for the DetectLabels request. Settings can include filters for both
/// GENERAL_LABELS and IMAGE_PROPERTIES. GENERAL_LABELS filters can be inclusive
/// or exclusive and
/// applied to individual labels or label categories. IMAGE_PROPERTIES filters
/// allow specification
/// of a maximum number of dominant colors.
pub const DetectLabelsSettings = struct {
    /// Contains the specified filters for GENERAL_LABELS.
    general_labels: ?GeneralLabelsSettings,

    /// Contains the chosen number of maximum dominant colors in an image.
    image_properties: ?DetectLabelsImagePropertiesSettings,

    pub const json_field_names = .{
        .general_labels = "GeneralLabels",
        .image_properties = "ImageProperties",
    };
};
