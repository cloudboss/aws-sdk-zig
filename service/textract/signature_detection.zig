const Geometry = @import("geometry.zig").Geometry;

/// Information regarding a detected signature on a page.
pub const SignatureDetection = struct {
    /// The confidence, from 0 to 100, in the predicted values for a detected
    /// signature.
    confidence: ?f32,

    geometry: ?Geometry,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .geometry = "Geometry",
    };
};
