const ImageStandardExtraction = @import("image_standard_extraction.zig").ImageStandardExtraction;
const ImageStandardGenerativeField = @import("image_standard_generative_field.zig").ImageStandardGenerativeField;

/// Standard Output Configuration of Image
pub const ImageStandardOutputConfiguration = struct {
    extraction: ?ImageStandardExtraction = null,

    generative_field: ?ImageStandardGenerativeField = null,

    pub const json_field_names = .{
        .extraction = "extraction",
        .generative_field = "generativeField",
    };
};
