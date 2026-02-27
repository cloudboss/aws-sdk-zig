/// Settings for the IMAGE_PROPERTIES feature type.
pub const DetectLabelsImagePropertiesSettings = struct {
    /// The maximum number of dominant colors to return when detecting labels in an
    /// image. The
    /// default value is 10.
    max_dominant_colors: i32 = 0,

    pub const json_field_names = .{
        .max_dominant_colors = "MaxDominantColors",
    };
};
