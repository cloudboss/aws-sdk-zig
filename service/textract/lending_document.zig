const LendingField = @import("lending_field.zig").LendingField;
const SignatureDetection = @import("signature_detection.zig").SignatureDetection;

/// Holds the structured data returned by AnalyzeDocument for lending documents.
pub const LendingDocument = struct {
    /// An array of LendingField objects.
    lending_fields: ?[]const LendingField = null,

    /// A list of signatures detected in a lending document.
    signature_detections: ?[]const SignatureDetection = null,

    pub const json_field_names = .{
        .lending_fields = "LendingFields",
        .signature_detections = "SignatureDetections",
    };
};
